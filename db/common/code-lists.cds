namespace codelist.models;

entity Currency {
    @Common.Label:'Código da Moeda'
    key code : String(3); // Ex: 'EUR', 'USD', 'AOA'
    @Common.Label:'Nome da Moeda'
    name   : String(50);
    @Common.Label:'Símbolo'
    symbol : String(5);
}
entity UnitMeasurement {
    @Common.Label:'Código da Unidade'
    key code : String(3); // Ex: 'UN', 'PC', 'KG'
    @Common.Label:'Nome da Unidade'
    name   : String(50);
}