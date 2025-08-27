const cds = require('@sap/cds');

class SalesService extends cds.ApplicationService {
    
    async init() {
        
        // Intercepta a criação/atualização de OrderItems
        this.before(['CREATE', 'UPDATE'], 'OrderItems', async (req) => {
            const { product_ID, quantity } = req.data;
            
            if (product_ID && quantity) {
                // Busca as informações do produto
                const product = await SELECT.one.from('db.models.Products')
                    .where({ ID: product_ID })
                    .columns(['price', 'stock', 'currency_code']);
                
                if (product) {
                    // Auto-preenche o preço unitário
                    req.data.unitPrice = product.price;
                    
                    // Calcula o preço total
                    req.data.totalPrice = product.price * quantity;
                    
                    // Validação de estoque
                    if (quantity > product.stock) {
                        req.error(400, `Quantidade solicitada (${quantity}) excede o estoque disponível (${product.stock})`);
                    }
                } else {
                    req.error(404, 'Produto não encontrado');
                }
            }
        });

        // Recalcula totais quando OrderItems são modificados
        this.after(['CREATE', 'UPDATE', 'DELETE'], 'OrderItems', async (data, req) => {
            const orderID = data.order_ID || req.data?.order_ID;
            
            if (orderID) {
                await this.recalculateOrderTotal(orderID);
            }
        });

        // Intercepta leitura de OrderItems para garantir campos calculados
        this.after('READ', 'OrderItems', (orderItems) => {
            const items = Array.isArray(orderItems) ? orderItems : [orderItems];
            
            items.forEach(item => {
                if (item && item.quantity && item.unitPrice) {
                    item.totalPrice = item.quantity * item.unitPrice;
                }
            });
        });

        return super.init();
    }

    // Método para recalcular o total do pedido
    async recalculateOrderTotal(orderID) {
        try {
            // Soma todos os itens do pedido
            const result = await SELECT.one`
                SUM(totalPrice) as total
            `.from('db.models.OrderItems')
             .where({ order_ID: orderID });

            const totalAmount = result?.total || 0;

            // Atualiza o pedido
            await UPDATE('db.models.Orders')
                .set({ totalAmount })
                .where({ ID: orderID });

        } catch (error) {
            console.error('Erro ao recalcular total do pedido:', error);
        }
    }

    // Action para atualizar status do pedido
    async updateOrderStatus(req) {
        const { ID } = req.params[0];
        const { newStatus } = req.data;

        const order = await UPDATE('Orders')
            .set({ status: newStatus })
            .where({ ID });

        return SELECT.one.from('Orders').where({ ID });
    }

    // Action para calcular total do pedido
    async calculateOrderTotal(req) {
        const { ID } = req.params[0];
        
        await this.recalculateOrderTotal(ID);
        
        const order = await SELECT.one.from('Orders')
            .where({ ID })
            .columns(['totalAmount']);

        return order?.totalAmount || 0;
    }

    // Action para adicionar item ao pedido
    async addOrderItem(req) {
        const { ID: orderID } = req.params[0];
        const { productID, quantity } = req.data;

        // Cria o novo item
        const newItem = await INSERT.into('OrderItems').entries({
            order_ID: orderID,
            product_ID: productID,
            quantity
        });

        // Retorna o pedido atualizado
        return SELECT.one.from('Orders').where({ ID: orderID });
    }
}

module.exports = SalesService;