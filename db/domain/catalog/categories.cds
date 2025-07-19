namespace categories.models;
using { products.models as products} from './products';

entity Categories {
    @Common.Label :'ID da Categoria'
    key ID        : UUID @(Core.Computed : true);
    @Common.Label :'Nome da Categoria'
    name          : String(100);
    @Common.Label :'Descrição da Categoria'
    description   : String(255);
    @Common.Label :'Imagem da Categoria'
    imagemUrl     : String(1000);
    @Common.Label :'Ícone'
    icone         : String(100);
    products      : Association to many products.Products on products.categorie = $self;
}