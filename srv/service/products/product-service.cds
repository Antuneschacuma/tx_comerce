using { products.models as db } from '../../../db/schema';

service ProductService  {
        
    @odata.draft.enabled : true
    entity Products as projection on db.Products;

    @odata.draft.enabled : true 
    entity Itens as projection on db.Itens;
}