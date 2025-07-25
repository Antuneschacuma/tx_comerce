// srv/service/products/products-service.cds
namespace products.services;

using {products.models as db} from '../../../db/schema';

service ProductService @(path: '/products') {
    entity Products as projection on db.Products { * }
        actions {

            action toggleProductStatus(productIDs : array of UUID, activate : Boolean) returns String;
            action updateProductPrice(newPrice : Decimal(10, 2))                       returns Products;
            action updateStock(quantityChange : Integer, operation : String)           returns Products;
        //   function getLowStockProducts() returns array of Products;
        //   function calculateTaxes () returns Decimal(10,2);

        };

}