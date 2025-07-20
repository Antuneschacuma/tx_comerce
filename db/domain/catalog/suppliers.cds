namespace suppliers.models;
using { products.models as products } from './products';
using { common.aspects as custonAspects,common.aspects.MyCustomManagedEntity } from '../../common/custom-aspects';
entity Suppliers : MyCustomManagedEntity {
    @Common.Label:'ID do Fornecedor'
    key ID       : UUID @(Core.Computed : true);
    @Common.Label:'Nome do Fornecedor'
    name         : String(150);
    @Common.Label:'Informações de Contato'
    contact      : String(255);
    @Common.Label:'CNPJ/NIF'
    document     : String(50);
    @Common.Label:'Inscrição Estadual'
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
    products     : Association to many products.Products on products.supplier = $self;
}