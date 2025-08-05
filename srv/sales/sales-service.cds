namespace sales.services;

using { db.models as db } from '../../db/schema';
using {common.aspects as custonAspects} from '../../db/common/custom-aspects';

service SalesService @(path : '/sales') {
    
    @cds.redirection.target: true
    entity Orders as projection on db.Orders {
        *,
        currency.name as currency_code_name
    } actions {
        action updateOrderStatus(newStatus: String) returns Orders;
        action calculateOrderTotal() returns Decimal(11,2);
        action addOrderItem(productID: UUID, quantity: Integer) returns Orders;
    };
    
    entity OrderItems as projection on db.OrderItems {
        *,
        product.name as product_name,
        product.price as product_current_price
    };
    
    // Entidades de apoio (readonly)
    @readonly entity Products as projection on db.Products;
    @readonly entity Currency as projection on custonAspects.Currency;
};