using {  MainService as service } from '../../main-service';

annotate service.Products with @(
    
    Capabilities.InsertRestrictions.Insertable : true,

    UI.HeaderInfo: {
        TypeName      : 'Produto',
        TypeNamePlural: 'Produtos',
        Title         : { Value: name },
        Description   : { Value:description }
    },

    UI.FieldGroup #GeneratedGroup: {
        $Type: 'UI.FieldGroupType',
        Data : [
            { $Type: 'UI.DataField', Value: name },
            { $Type: 'UI.DataField', Value:description },
            { $Type: 'UI.DataField', Value:price },
            { $Type: 'UI.DataField', Value: stock},
            { $Type: 'UI.DataField', Value: rating }, 
            { $Type: 'UI.DataField', Value: categorie_ID ,Label:'Id da categoria'}, 
            { $Type: 'UI.DataField', Value: supplier_ID ,Label:'Id do fornecedor'} 
        ]
    },

    UI.Facets: [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneratedFacet1',
            Label : 'Informações Gerais',
            Target: '@UI.FieldGroup#GeneratedGroup'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'ItensFacet',
            Label : 'Itens do Produto',
            Target: 'itens/@UI.LineItem'
        }
    ],

    UI.SelectionFields: [ID, name,description,price, categorie_ID, supplier_ID],

    UI.LineItem: [
        { $Type: 'UI.DataField', Value: name },
        { $Type: 'UI.DataField', Value:description },
        { $Type: 'UI.DataField', Value:price },
        { $Type: 'UI.DataField', Value: stock},
        { $Type: 'UI.DataField', Value: rating }
    ]
);

annotate service.Itens with @(
    UI.LineItem: [
        { $Type: 'UI.DataField', Value: quantity},
        { $Type: 'UI.DataField', Value: observation},
        { $Type: 'UI.DataField', Value:totalPrice}
    ]
);

annotate service.Products with {
    name @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Products',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : name,
                    ValueListProperty : 'name',
                },
            ],
        }
    );

    categorie @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Categories',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : categorie_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
            ],
        },
        Common.ValueListWithFixedValues : true
    );

    supplier @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Suppliers',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : supplier_ID,
                    ValueListProperty : 'ID',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
            ],
        },
        Common.ValueListWithFixedValues : true
    );
   
};
