namespace sales.models;

using { products.models as products } from '../catalog/products';
using { common.aspects as custonAspects,common.aspects.MyCustomManagedEntity } from '../../common/custom-aspects';

entity Orders      : MyCustomManagedEntity {
    @Common.Label  :'ID do Pedido'
    key ID         : UUID @(Core.Computed : true);
    @Common.Label  :'Data do Pedido'
    orderDate      : Date;
    @Common.Label  :'Status do Pedido'
    status         : String(50);
    @Common.Label  :'Valor Total do Pedido'
    totalAmount    : Decimal(11, 2) @(Measures.Unit : currency_code.code);
    @Common.Label  :'Moeda do Pedido'
    currency_code  : Association to custonAspects.Currency;
    @Common.Label  :'Cliente'
    // Se você tiver uma entidade de Clientes, associaria aqui
    // customer       : Association to customers.models.Customer;
    // O Pedido tem muitos Itens
    items          : Association to many OrderItems on items.order = $self;
}
 
entity OrderItems  : MyCustomManagedEntity {
    @Common.Label  :'ID do Item do Pedido'
    key ID         : UUID @(Core.Computed : true);
    @Common.Label  :'Quantidade do Item'
    quantity       : Integer;
    @Common.Label  :'Preço Unitário no momento da compra'
    unitPrice      : Decimal(10, 2) @(Measures.Unit : product.currency_code.code);
    @Common.Label  :'Observações do Item'
    observation    : String(500);
    @Common.Label  :'Preço Total do Item'
    totalPrice     : Decimal(11, 2) @(Measures.Unit : product.currency_code.code);
    @Common.Label  :'Produto Associado'
    product        : Association to products.Products;
    @Common.Label  :'Pedido Associado'
    order          : Association to Orders;
}