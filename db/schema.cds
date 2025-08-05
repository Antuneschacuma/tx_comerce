namespace db.models;
using { common.aspects as custonAspects,common.aspects.MyCustomManagedEntity } from './common/custom-aspects';

entity Products    :MyCustomManagedEntity {
    @Common.Label  :'Nome'
    name           : String(100)  @cds.personalData : true;
    @Common.Label  :'Descrição'
    description    : String(500)  @cds.personalData : true;
    @Common.Label  :'Preço Unitário'
    price          : Decimal(10, 2) @cds.sensitive    : true @(Measures.Unit:currency.code);
    @Common.Label  :'Quantidade'
    stock          : Integer @cds.sensitive    : true @(Measures.Unit : measure.code);
    @Common.Label  :'Data de Validade'
    expirationDate : Date;
    @Common.Label  :'URL da Imagem Principal'
    imagemUrl      : String(1000);
    @Common.Label  :'Ativo'
    active         : Boolean default true;
    @Common.Label  :'Avaliação Média'
    rating         : Decimal(2, 1);
    @Common.Text   : supplier.name
    supplier       : Association to Suppliers;
    @Common.Text   : currency.name
    currency       : Association to custonAspects.Currency;
    @Common.Text   : category.name
    category       : Association to Categories;
    @Common.Text   : measure.name
    measure        : Association to custonAspects.UnitMeasurement;
    itens          : Association to many OrderItems on itens.product = $self;
}

entity Categories : MyCustomManagedEntity {
    @Common.Label :'Categoria'
    name          : String(100);
    @Common.Label :'Descrição'
    description   : String(255);
    @Common.Label :'url da Categoria'
    imagemUrl     : String(1000);
    @Common.Label :'Ícone'
    icone         : String(100);
    products      : Association to many Products on products.category = $self;
}

entity Suppliers : MyCustomManagedEntity {
    @Common.Label:'Fornecedor'
    name         : String(150);
    @Common.Label:'Contato'
    contact      : String(255);
    @Common.Label:'NIF'
    document     : String(50);
    @Common.Label:'Email'
    email        : String(150);
    @Common.Label:'Telefone'
    telefone     : String(20);
    @Common.Label:'Website'
    website      : String(200);
    @Common.Label:'Endereço'
    address      : String(300);
    @Common.Label:'Cidade'
    city         : String(100);
    @Common.Label:'Estado'
    state        : String(50);
    @Common.Label:'Prazo de Entrega'
    delivery     : Integer; // em dias
    @Common.Label:'Avaliação'
    rating       : Decimal(2,1) default 0.0;
    @Common.Label:'Observações'
    observations : String(1000);
    @Common.Label:'País'
    country      : Association to custonAspects.Country;
    products     : Association to many Products on products.supplier = $self;
}


entity Orders      : MyCustomManagedEntity {
    @Common.Label  :'Data do Pedido'
    orderDate      : Date;
    @Common.Label  :'Status do Pedido'
    status         : String(50);
    @Common.Label  :'Valor Total do Pedido'
    totalAmount    : Decimal(11, 2) @(Measures.Unit : currency.code);
    @Common.Label  :'Moeda do Pedido'
    currency       : Association to custonAspects.Currency;
    @Common.Label  :'Cliente'
    items          : Association to many OrderItems on items.order = $self;
}
 
entity OrderItems  : MyCustomManagedEntity {
    @Common.Label  :'Quantidade do Item'
    quantity       : Integer;
    @Common.Label  :'Preço Unitário no momento da compra'
    unitPrice      : Decimal(10, 2) @(Measures.Unit : product.currency_code);
    @Common.Label  :'Observações do Item'
    observation    : String(500);
    @Common.Label  :'Preço Total do Item'
    totalPrice     : Decimal(11, 2) @(Measures.Unit : product.currency_code);
    @Common.Label  :'Produto Associado'
    product        : Association to Products;
    @Common.Label  :'Pedido Associado'
    order          : Association to Orders;
}

