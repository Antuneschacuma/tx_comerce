namespace products.models;

using { sales.models as sales } from '../sales/orders';
using { suppliers.models as suppliers } from './suppliers';
using { categories.models as categories } from './categories';
using { common.aspects as custonAspects,common.aspects.MyCustomManagedEntity } from '../../common/custom-aspects';

entity Products    :MyCustomManagedEntity {
    @Common.Label  :'ID do Produto'
    key ID         : UUID @(Core.Computed : true);
    @Common.Label  :'Nome do Produto'
    name           : String(100);
    @Common.Label  :'Descrição Detalhada'
    description    : String(500);
    @Common.Label  :'Preço Unitário'
    price          : Decimal(10, 2);
    @Common.Label  :'Quantidade'
    stock          : Integer;
    @Common.Label  :'Data de Validade'
    expirationDate : Date;
    @Common.Label  :'URL da Imagem Principal'
    imagemUrl      : String(1000);
    @Common.Label  :'Ativo'
    active         : Boolean default true;
    @Common.Label  :'Avaliação Média'
    rating         : Decimal(2, 1);
    supplier       : Association to suppliers.Suppliers;
    currency       : Association to custonAspects.Currency;
    categorie      : Association to categories.Categories;
    measure        : Association to custonAspects.UnitMeasurement;
    itens          : Association to many sales.OrderItems on itens.product = $self;
}