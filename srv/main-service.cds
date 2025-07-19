using { ProductService  as ExternalProductService } from './service/products/product-service';
using { CategoryService as ExternalCategoryService} from './service/categories/categories-service';
using { SuppliersService as ExternalSuppliersService} from './service/suppliers/suppliers-service';
using { SharedServices  as ExternalSharedService} from './common/common';



service MainService @(path : '/e-comerce') {

    entity Products @(odata.draft.enabled : true) as projection on ExternalProductService.Products;
    entity Itens    @(odata.draft.enabled : true) as projection on ExternalProductService.Itens;

    entity Categories as projection on ExternalCategoryService.Categories;
    entity Suppliers as projection on ExternalSuppliersService.Suppliers;

    entity Currency as projection on ExternalSharedService.Currency;
    entity UnitMeasurement as projection on ExternalSharedService.UnitMeasurement;
}