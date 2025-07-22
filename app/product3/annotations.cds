using MainService as service from '../../srv/main-service';
annotate service.Products with @(
        odata.draft.enabled : true,
    Capabilities.InsertRestrictions.Insertable : true,

    UI.HeaderInfo: {
        TypeName      : 'Produto',
        TypeNamePlural: 'Produtos',
        Title         : { Value: name },
        Description   : { Value:description }
    },

       UI.DataPoint #RatingProduct: {
        $Type         : 'UI.DataPointType',
        Value         : rating,
        Title         : 'Avaliação Média',
        Visualization : #Rating,
        TargetValue   : 5,
    },

 UI.FieldGroup #GeneralInfo: {
        $Type: 'UI.FieldGroupType',
        Data : [
            { $Type: 'UI.DataField', Value: ID, Label: 'ID do Produto' },
            { $Type: 'UI.DataField', Value: name },
            { $Type: 'UI.DataField', Value: description },
            { $Type: 'UI.DataField', Value: imagemUrl },
            { $Type: 'UI.DataFieldForAnnotation', Target: '@UI.DataPoint#RatingProduct' }
        ]
    },

 UI.FieldGroup #PricingAndStock: {
        $Type: 'UI.FieldGroupType',
        Data : [
            { $Type: 'UI.DataField', Value: price },
            { $Type: 'UI.DataField', Value: currency_code, Label:'Código da Moeda'},
            { $Type: 'UI.DataField', Value: stock }, 
            { $Type: 'UI.DataField', Value: measure_code ,Label:'Código da Unidade'},
            { $Type: 'UI.DataField', Value: expirationDate },
            { $Type: 'UI.DataField', Value: active },
            { $Type: 'UI.DataField', Value: rating }
        ]
    },

    UI.FieldGroup #Associations: {
        $Type: 'UI.FieldGroupType',
        Data : [
            { $Type: 'UI.DataField', Value: categorie_ID, Label: 'Categoria' },
            { $Type: 'UI.DataField', Value: supplier_ID, Label: 'Fornecedor' }
        ]
    },

    UI.FieldGroup #AuditInfo: {
        $Type: 'UI.FieldGroupType',
        Data : [
            { $Type: 'UI.DataField', Value: createdAt, Label: 'Criado Em' },
            { $Type: 'UI.DataField', Value: createdBy, Label: 'Criado Por' },
            { $Type: 'UI.DataField', Value: modifiedAt, Label: 'Modificado Em' },
            { $Type: 'UI.DataField', Value: modifiedBy, Label: 'Modificado Por' }
        ]
    },

    UI.Facets: [
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'GeneralInfoFacet',
            Label : 'Informações Gerais',
            Target: '@UI.FieldGroup#GeneralInfo'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'PricingStockFacet',
            Label : 'Preço e Estoque',
            Target: '@UI.FieldGroup#PricingAndStock'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'AssociationsFacet',
            Label : 'Associações',
            Target: '@UI.FieldGroup#Associations'
        },
        {
            $Type : 'UI.ReferenceFacet',
            ID    : 'AuditInfoFacet',
            Label : 'Auditoria',
            Target: '@UI.FieldGroup#AuditInfo'
        }
    ],
   UI.LineItem: [
    { $Type: 'UI.DataField', Value: ID, Label: 'ID' },
    { $Type: 'UI.DataField', Value: name },
    { $Type: 'UI.DataField', Value: description },
    { $Type: 'UI.DataField', Value: price },
    { $Type: 'UI.DataField', Value: stock },
    { $Type: 'UI.DataField', Value: rating },
    { $Type: 'UI.DataField', Value: active }, 
    { $Type: 'UI.DataField', Value: categorie.name, Label: 'Categoria' }, 
    { $Type: 'UI.DataField', Value: supplier.name, Label: 'Fornecedor' }, 
    { $Type: 'UI.DataField', Value: createdAt, Label: 'Criado Em' }, 
    { $Type: 'UI.DataField', Value: modifiedAt, Label: 'Modificado Em' },
],

   UI.SelectionFields: [
    ID,
    name,
    description,
    price,
    stock,
    active,  
    categorie_ID,
    supplier_ID,
    expirationDate 
],
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
                    ValueListProperty : 'name'
                },
              
            ],
        
        },
        Common.ValueListWithFixedValues : true
    );
     currency @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Currency',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : currency_code,
                    ValueListProperty : 'code', 
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name', 
                },
            ],
        },
        Common.ValueListWithFixedValues : true
    );
     measure @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'UnitMeasurement',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : measure_code,
                    ValueListProperty : 'code',
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