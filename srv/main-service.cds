using { common.services.SharedServices } from './common/common-service';
using { sales.services.SalesService  } from './service/sales/sales-service';
using { products.services.ProductService  } from './service/products/products-service';
using {suppliers.services.SuppliersService} from './service/suppliers/suppliers-service';
using { categories.services.CategoryService} from './service/categories/categories-service';

service MainService @(path : '/e-commerce') {

    entity Products        as projection on ProductService.Products;
    entity Categories      as projection on CategoryService.Categories;
    entity Suppliers       as projection on SuppliersService.Suppliers;
    entity Orders          as projection on SalesService.Orders;
    entity OrderItems      as projection on SalesService.OrderItems;
    entity Currency        as projection on SharedServices.Currency;
    entity UnitMeasurement as projection on SharedServices.UnitMeasurement;
}