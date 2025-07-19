namespace codelist.models;

entity Currency {
    @Common.Label:'Código da Moeda'
    key code     : String(3); // Ex: 'EUR', 'USD', 'AOA'
    @Common.Label:'Nome da Moeda'
    name         : String(50);
    @Common.Label:'Símbolo'
    symbol       : String(5);
    @Common.Label:'Taxa de Câmbio'
    exchangeRate : Decimal(10,6) default 1.0;
    @Common.Label:'Moeda Padrão'
    standard     : Boolean default false;
}
entity UnitMeasurement {
    @Common.Label:'Código da Unidade'
    key code     : String(3); // Ex: 'UN', 'PC', 'KG'
    @Common.Label:'Nome da Unidade'
    name         : String(50);
    @Common.Label:'Tipo'
    type         : String enum { weight; volume; length; area; unit };
}

entity Country {
    @Common.Label:'Código do País'
    key code     : String(2); // BR,PT,EUA,AOA
    @Common.Label:'Nome do País'
    name         : String(100);
    @Common.Label:'Código de Discagem'
    dialingCode  : String(10);
    @Common.Label:'Moeda Padrão'
    standartCurrency : Association to Currency;
}