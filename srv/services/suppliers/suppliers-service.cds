namespace suppliers.services;
using{ suppliers.models as db} from '../../../db/schema';

service SuppliersService @(path : '/suppliers') {
    entity Suppliers as projection on db.Suppliers;
}