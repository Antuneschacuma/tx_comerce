// app/manage/products.cds
using { MainService as service } from '../../srv/main-service';

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
        Visualization : #Rating, // Isso transforma o número em estrelinhas
        TargetValue   : 5,        // O valor máximo para as estrelas (e.g., de 0 a 5 estrelas)
        // criticaliy: Se você quiser cores de criticidade baseadas no valor, use
        // Criticality : rating, // Se 'rating' retornasse um valor de criticidade (0-4), ou
        // CriticalityCalculation: {
        //     Expression: 'If',
        //     If        : [
        //         { LT: rating, '3' }, #Error, // Se rating < 3, vermelho
        //         { LT: rating, '4' }, #Critical, // Se rating < 4, laranja
        //         #Good // Acima de 4, verde
        //     ]
        // }
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
    { $Type: 'UI.DataFieldForAnnotation', Target: '@UI.DataPoint#RatingProduct' }
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
            CollectionPath : 'Categories', // Aponta para a Entity Set 'Categories' no MainService
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : categorie_ID, // Campo local (no produto) que será preenchido
                    ValueListProperty : 'ID', // Campo do Value Help (na Categoria) que será usado para preencher o local
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name', // <-- ISSO FAZ O NOME DA CATEGORIA APARECER NO VALUE HELP
                },
                // Se você quiser que o campo 'name' da categoria seja um campo de busca/filtro no Value Help
                // {
                //     $Type : 'Common.ValueListParameterIn',
                //     ValueListProperty : 'name',
                // }
            ],
            // Adicional: Ordenar a lista de categorias por nome
            // SortRestrictions : [
            //     { Property: 'name', Descending: false }
            // ]
        },
        Common.ValueListWithFixedValues : true // Útil se a lista de categorias for pequena e fixa
    );

    supplier @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Suppliers', // Aponta para a Entity Set 'Suppliers' no MainService
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : supplier_ID, // Campo local (no produto)
                    ValueListProperty : 'ID', // Campo do Value Help (no Fornecedor)
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name', // <-- ISSO FAZ O NOME DO FORNECEDOR APARECER NO VALUE HELP
                },
                // Se você quiser que o campo 'name' do fornecedor seja um campo de busca/filtro no Value Help
                // {
                //     $Type : 'Common.ValueListParameterIn',
                //     ValueListProperty : 'name',
                // }
            ],
            // Adicional: Ordenar a lista de fornecedores por nome
            // SortRestrictions : [
            //     { Property: 'name', Descending: false }
            // ]
        },
        Common.ValueListWithFixedValues : true
    );
     currency @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Currency', // Aponta para a Entity Set 'Suppliers' no MainService
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : currency_code, // Campo local (no produto)
                    ValueListProperty : 'code', // Campo do Value Help (no Fornecedor)
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name', // <-- ISSO FAZ O NOME DO FORNECEDOR APARECER NO VALUE HELP
                },
                // Se você quiser que o campo 'name' do fornecedor seja um campo de busca/filtro no Value Help
                // {
                //     $Type : 'Common.ValueListParameterIn',
                //     ValueListProperty : 'name',
                // }
            ],
            // Adicional: Ordenar a lista de fornecedores por nome
            // SortRestrictions : [
            //     { Property: 'name', Descending: false }
            // ]
        },
        Common.ValueListWithFixedValues : true
    );
     measure @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'UnitMeasurement', // Aponta para a Entity Set 'Suppliers' no MainService
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : measure_code, // Campo local (no produto)
                    ValueListProperty : 'code', // Campo do Value Help (no Fornecedor)
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name', // <-- ISSO FAZ O NOME DO FORNECEDOR APARECER NO VALUE HELP
                },
                // Se você quiser que o campo 'name' do fornecedor seja um campo de busca/filtro no Value Help
                // {
                //     $Type : 'Common.ValueListParameterIn',
                //     ValueListProperty : 'name',
                // }
            ],
            // Adicional: Ordenar a lista de fornecedores por nome
            // SortRestrictions : [
            //     { Property: 'name', Descending: false }
            // ]
        },
        Common.ValueListWithFixedValues : true
    );
};