using {codelist.models as ExternalServiceCodeList} from '../../db/schema';

service SharedServices @(path:'/shared') {
        entity Currency as projection on ExternalServiceCodeList.Currency;
        entity UnitMeasurement as projection on ExternalServiceCodeList.UnitMeasurement;
}