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
        action suggestProductPrice(category: String, stock: Integer) returns Decimal(10,2);
        action toggleProductStatus(productIDs: array of UUID, activate: Boolean) returns String;
    
      
       
    };

    @readonly entity Suppliers as projection on db.Suppliers; 
    @readonly entity Categories as projection on db.Categories;
    @readonly entity Country as projection on custonAspects.Country;
    @readonly entity Currency as projection on custonAspects.Currency;
    @readonly entity UnitMeasurement as projection on custonAspects.UnitMeasurement;
};