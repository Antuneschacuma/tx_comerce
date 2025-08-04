namespace sales.services;

using { db.models as db } from '../../db/schema';

service SalesService @(path : '/sales') {
    entity Orders as projection on db.Orders;
    entity OrderItems as projection on db.OrderItems;
}