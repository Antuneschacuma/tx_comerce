namespace products.services;
using {db.models as db} from '../../db/schema';
using {common.aspects as custonAspects} from '../../db/common/custom-aspects';

service ProductService @(path: '/products') {

    @cds.redirection.target: true
    entity Products as projection on db.Products {
        *,
        category.name as category_name,
        supplier.name as supplier_name,
        currency.name as currency_name,
        measure.name as measure_name,
        
    } actions {
        action updateProductPrice(newPrice: Decimal(10, 2)) returns Products;
        action updateStock(quantityChange: Integer, operation: String) returns Products;
        action toggleProductStatus(productIDs: array of UUID, activate: Boolean) returns String;
    
      
       
    };

     entity Suppliers as projection on db.Suppliers; 
     entity Categories as projection on db.Categories;
     entity Country as projection on custonAspects.Country;
     entity Currency as projection on custonAspects.Currency;
     entity UnitMeasurement as projection on custonAspects.UnitMeasurement;
};