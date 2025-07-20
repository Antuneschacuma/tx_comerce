namespace common.services;
using {common.aspects as customAspect} from '../../db/schema';

service SharedServices @(path:'/shared') {
        entity Currency as projection on customAspect.Currency;
        entity UnitMeasurement as projection on customAspect.UnitMeasurement;
}