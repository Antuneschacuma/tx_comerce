namespace categories.services;
using{ categories.models as db } from '../../../db/schema';

service CategoryService @(path : '/categories') {
    entity Categories as projection on db.Categories;
}