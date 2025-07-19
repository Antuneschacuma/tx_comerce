namespace db.domain.catalog;
using {db.domain.products as products} from './prooducts';

entity Categories {
    @Common.Label:'ID da Categoria'
    key ID    : UUID @(Core.Computed : true);
    @Common.Label:'Nome da Categoria'
    name  : String(100);
    @Common.Label:'Descrição da Categoria'
    description : String(255);
    products  : Association to many products.Products on products.categorie = $self;
}