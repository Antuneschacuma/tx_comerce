using {db.domain.suppliers as suppliers} from './suppliers';
using {db.domain.catalog as categories } from './categories';
using {db.common.codelist as codeLists} from '../../common/code-lists';

namespace db.domain.products;

entity Products {
    @Common.Label:'ID do Produto'
    key ID         : UUID @(Core.Computed : true);
    @Common.Label:'Nome do Produto'
    name       : String(100); //@(Common.Text : descricao);
    @Common.Label:'Descrição Detalhada'
    description  : String(500);
    @Common.Label:'Preço Unitário'
    price      : Decimal(10, 2);
    @Common.Label:'Unidade de Medida'
    unitMeasure_code : Association to codeLists.UnitMeasurement;
    @Common.Label:'Moeda'
    currency_code : Association to codeLists.Currency;
    @Common.Label:'Quantidade' 
    stock    : Integer;
    @Common.Label:'Data de Validade'
    expirationDate : Date;
    @Common.Label:'URL da Imagem Principal'
    imagemUrl  : String(1000);
    @Common.Label:'Ativo'
    active      : Boolean default true;
    @Common.Label:'Avaliação Média'
    rating     : Decimal(2, 1);
    categorie  : Association to categories.Categories;
    supplier : Association to suppliers.Suppliers;
    itens      : Association to many Itens on itens.product = $self;
}

entity Itens {
    @Common.Label:'ID do Item'
    key ID          : UUID @(Core.Computed : true);
    @Common.Label:'Quantidade do Item'
    quantity    : Integer;
    @Common.Label:'Observações do Item'
    observation   : String(500);
    @Common.Label:'Preço Total do Item'
    totalPrice    : Decimal(11, 2) @(Measures.Unit : product.currency_code.code);
    @Common.Label:'Sugestão de Ação'
    product       : Association to Products;
}