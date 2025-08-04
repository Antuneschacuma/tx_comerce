// srv/service/products/products.js
const cds = require('@sap/cds');
// Importar o módulo 'fiori-elements-internationalization' para usar as mensagens i18n
// O CDS carrega automaticamente os arquivos _i18n.properties.
// Podemos acessá-los através de req.error ou cds.error, que buscarão as mensagens.

class ProductService extends cds.ApplicationService {
    async init() {
        const { Products } = this.entities;

        // --- Validações (Hooks) ---
        this.before(['CREATE', 'UPDATE'], Products, this.validateProductData);
        // this.after(['CREATE', 'UPDATE'], Products, this.logProductChange);

        // // --- Handlers para Actions e Functions ---
        // this.on('toggleProductStatus', this.toggleProductStatusHandler);
        // this.on('getLowStockProducts', this.getLowStockProductsHandler);
        // this.on('updateProductPrice', this.updateProductPriceHandler);
        this.on('updateStock', this._updateStockHandler); // Handler para a nova Action de estoque

        return super.init();
    }

    // --- Métodos de Validação ---

    /**
     * Valida dados essenciais do Produto antes de criar ou atualizar.
     * Usa mensagens do arquivo i18n.
     */
    validateProductData(req) {
        const { name } = req.data;

        if (!name || name.trim() === '') {
            // O target indica qual campo específico do payload causou o erro
            return req.error('PRODUCT_NAME_EMPTY');
        }
        // if (price === undefined || price === null || price <= 0) {
        //     req.error({ code: '400', message: req.i18n.t('PRODUCT_INVALID_PRICE'), target: 'price' });
        // }
        // if (stock === undefined || stock === null || stock < 0) {
        //     req.error({ code: '400', message: req.i18n.t('PRODUCT_INVALID_STOCK'), target: 'stock' });
        // }
        // if (expirationDate && new Date(expirationDate) < new Date()) {
        //     req.error({ code: '400', message: req.i18n.t('PRODUCT_EXPIRED_DATE'), target: 'expirationDate' });
        // }
        // if (imagemUrl && !/^https?:\/\/.+\.(jpg|jpeg|png|gif|bmp)$/i.test(imagemUrl)) {
        //      req.error({ code: '400', message: req.i18n.t('PRODUCT_INVALID_IMAGE_URL'), target: 'imagemUrl' });
        // }
    }

    // /**
    //  * Exemplo de método 'after' hook: Loga mudanças em um produto.
    //  * Não precisa de i18n aqui, pois é um log interno.
    //  */
    // logProductChange(data, req) {
    //     console.log(`Produto ${data.ID} (${data.name}) foi ${req.event}.`);
    // }

    // // --- Métodos para Handlers de Actions e Functions ---

    // /**
    //  * Handler para a Action 'toggleProductStatus'.
    //  * Usa mensagens do arquivo i18n.
    //  */
    // async toggleProductStatusHandler(req) {
    //     const { productIDs, activate } = req.data;
    //     const { Products } = this.entities;

    //     if (!productIDs || productIDs.length === 0) {
    //         req.error({ code: '400', message: req.i18n.t('MISSING_PRODUCT_IDS') });
    //     }

    //     try {
    //         const result = await cds.update(Products)
    //             .set({ active: activate })
    //             .where({ ID: { in: productIDs } });

    //         // Não há uma mensagem de sucesso explícita no i18n para isso,
    //         // mas poderia ser adicionada se o retorno fosse complexo.
    //         return `Status de ${result.rowsAffected} produto(s) atualizado(s) para ${activate ? 'ativo' : 'inativo'}.`;
    //     } catch (error) {
    //         req.error({ code: '500', message: req.i18n.t('UPDATE_FAILED', error.message) });
    //     }
    // }

    // /**
    //  * Handler para a Function 'getLowStockProducts'.
    //  */
    // async getLowStockProductsHandler(req) {
    //     const LOW_STOCK_THRESHOLD = 20;
    //     const { Products } = this.entities;
    //     const lowStockProducts = await cds.read(Products)
    //         .where`active = true and stock < ${LOW_STOCK_THRESHOLD}`;
    //     return lowStockProducts;
    // }

    // /**
    //  * Handler para a Action de instância 'updateProductPrice'.
    //  * Usa mensagens do arquivo i18n.
    //  */
    // async updateProductPriceHandler(req) {
    //     const { ID } = req.target;
    //     const { newPrice } = req.data;
    //     const { Products } = this.entities;

    //     if (newPrice === undefined || newPrice === null || newPrice <= 0) {
    //         req.error({ code: '400', message: req.i18n.t('INVALID_NEW_PRICE'), target: 'newPrice' });
    //     }

    //     try {
    //         await cds.update(Products)
    //             .set({ price: newPrice })
    //             .where({ ID: ID });
    //         // Retorna o produto atualizado para a UI (conforme definido no CDS)
    //         return await cds.read(Products, ID);
    //     } catch (error) {
    //         req.error({ code: '500', message: req.i18n.t('PRICE_UPDATE_FAILED', error.message) });
    //     }
    // }

    // /**
    //  * Handler para a nova Action 'updateStock'.
    //  * Gerencia a adição ou remoção de estoque para um produto.
    //  * Usa mensagens do arquivo i18n.
    //  * @param {object} req - O objeto de requisição da Action.
    //  */
    async _updateStockHandler(req) {
        const { ID } = req.params[0];
        const { quantityChange, operation } = req.data;
        const { Products } = this.entities;
    
       
    if (isNaN(quantityChange) || quantityChange <= 0) {
        return req.error('INVALID_STOCK_QUANTITY')//(404, req.i18n.getText('INVALID_STOCK_QUANTITY'));
    }
    
    if (!['ADD', 'SUBTRACT'].includes(operation)) {
        return req.error(400, req.i18n.getText('INVALID_OPERATION_METHOD'));
    }
    
        try {
            const product = await SELECT.one.from(Products, ID).columns('stock','name');
            if (!product) {
                return req.error(404, req.i18n.getText('PRODUCT_NOT_FOUND_FOR_STOCK_UPDATE', [ID]));
            }
    
            // Cálculo do novo estoque
            let newStock = product.stock;
            if (operation === 'ADD') {
                newStock += quantityChange;
            } else {
                if (product.stock < quantityChange) {
                    return req.error(400, req.i18n.getText('STOCK_INSUFFICIENT', 
                        [product.name, product.stock, quantityChange]));
                }
                newStock -= quantityChange;
            }
    
            // Atualização
            await UPDATE(Products, ID).with({ stock: newStock });
            
            // Retorna o produto atualizado conforme definido no CDS
            return SELECT.one.from(Products, ID);
            
        } catch (error) {
            return req.error(500, req.i18n.getText('STOCK_UPDATE_FAILED'));
        }
    }
}

module.exports = ProductService;