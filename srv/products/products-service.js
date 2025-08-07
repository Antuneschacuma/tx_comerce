const cds = require('@sap/cds');

class ProductService extends cds.ApplicationService {
    async init() {
        const { Products, Categories } = this.entities;

        //Minhas Acoes
        this.on('updateStock', this.updateStockHandler);
        this.on('updateProductPrice',this.updateProductPriceHandler);
        this.on('toggleProductStatus', Products, this.toggleProductStatusHandler);
        
        //Minhas Validacoes
        this.before('CREATE', Products, this.validateProductHandler);
        this.after('CREATE', Products, this.afterCreateProductHandler);
        this.after('UPDATE', Products, this.afterUpdateProductHandler);
        
        await super.init();
    }

    async updateProductPriceHandler(req) {
        try {
            const { ID } = req.params[0] || req.data;
            const { newPrice } = req.data;
        
            if (!newPrice || newPrice <= 0) {
                req.error('INVALID_NEW_PRICE');
                return;
            }

            const result = await this.run(
                UPDATE('Products')
                    .set({ 
                        price: newPrice,
                        modifiedAt: new Date(),
                        modifiedBy: req.user.id || 'system'
                    })
                    .where({ ID })
            );
            
            if (result === 0) {
                req.error('PRODUCT_NOT_FOUND');
                return;
            }

            const updatedProduct = await this.run(
                SELECT.one.from('Products').where({ ID })
            );
            
            req.info(`Preço do/a ${updatedProduct.name} atualizado para ${newPrice}`);
            return updatedProduct;
            
        } catch (error) {
            req.error(500, 'Erro interno do servidor');
        }
    }

    async updateStockHandler(req) {
        try {
            const { ID } = req.params[0] || req.data;
            const { quantityChange, operation } = req.data;

            const product = await this.run(SELECT.one.from('Products').where({ ID }));
            
            if (!product) {req.error('PRODUCT_NOT_FOUND');
                return;
            }

            let newStock;
                
            switch (operation) {
                case 'ADD':
                    newStock = product.stock + quantityChange;
                    break;
                case 'SUBTRACT':
                    newStock = product.stock - quantityChange;
                    break;
                case 'SET':
                    newStock = quantityChange;
                    break;
                default:
                    req.error('INVALID_OPERATION_METHOD');
                    return;
            }

            if (newStock < 0) {req.error('INVALID_STOCK_QUANTITY');
                return;
            }

            await this.run( UPDATE('Products').set({ 
                        stock: newStock,
                        modifiedAt: new Date(),
                        modifiedBy: req.user.id || 'system'
                    }) .where({ ID })
            );

            const updatedProduct = await this.run( SELECT.one.from('Products').where({ ID }));
            
            req.info(`Estoque do/a ${product.name} atualizado para ${newStock}`);
            return updatedProduct;
            
        } catch (error) {
            req.error(500, 'Erro interno do servidor');
        }
    }
    
    async toggleProductStatusHandler(req) {
        try {
            const { productIDs, activate } = req.data;
            
            if (!productIDs || productIDs.length === 0) {req.error(400, 'Nenhum produto selecionado');
                return;
            }

            const result = await this.run(UPDATE('Products').set({ 
                        active: activate,
                        modifiedAt: new Date(),
                        modifiedBy: req.user.id || 'system'
                    })
                    .where({ ID: { in: productIDs } })
            );

            const action = activate ? 'ativados' : 'desativados';
            const message = `${result} produto(s) ${action} com sucesso`;
            
            req.info(message);
            return message;
            
        } catch (error) {
            req.error(500, 'Erro interno do servidor');
        }
    }

    async validateProductHandler(req) {
        const { name, stock, price, expirationDate, category_ID, imagemUrl } = req.data;
        
        if (!name || name.trim() === '') {
            return req.error('PRODUCT_NAME_EMPTY');
        }
        if (price === undefined || price === null || price <= 0) {
            req.error('PRODUCT_INVALID_PRICE');
        }
        if (stock === undefined || stock === null || stock < 0) {
            req.error('PRODUCT_INVALID_STOCK');
        }
        if (expirationDate && new Date(expirationDate) < new Date()) {
            req.error('PRODUCT_EXPIRED_DATE');
        }
        if (imagemUrl && !/^https?:\/\/.+\.(jpg|jpeg|png|gif|bmp)$/i.test(imagemUrl)) {
            req.error('PRODUCT_INVALID_IMAGE_URL');
        }

        if (category_ID) {
            const category = await this.run(
                SELECT.one.from('Categories').where({ ID: category_ID })
            );
            if (category && category.name === 'Perecível' && !expirationDate) {
                req.error(400, 'Data de expiração é obrigatória para produtos perecíveis');
            }
        }
    }
    
    async afterCreateProductHandler(result, req) {
        req.info(`Produto ${result.name} criado com sucesso`);
    }

    async afterUpdateProductHandler(result, req) {
        if (result) {
            req.info(`Produto atualizado com sucesso`);
        }
    }
}

module.exports = ProductService;