namespace products.services;

using { products.models as db } from '../../../db/schema';

service ProductService @(path:'/products')  {
    entity Products as projection on db.Products {
        *
    };
}