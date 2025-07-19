namespace db.domain.suppliers;
using {db.domain.products as products} from './prooducts';

entity Suppliers {
    @Common.Label:'ID do Fornecedor'
    key ID    : UUID @(Core.Computed : true);
    @Common.Label:'Nome do Fornecedor'
    name  : String(150);
    @Common.Label:'Informações de Contato'
    contact : String(255);
    products  : Association to many products.Products on products.supplier = $self;
}