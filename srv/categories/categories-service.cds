namespace categories.services;
using{ db.models as db } from '../../db/schema';

service CategoryService @(path : '/categories') {
    entity Categories as projection on db.Categories;
}