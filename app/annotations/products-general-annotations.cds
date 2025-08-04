using {products.services.ProductService as prod} from '../../srv/products/products-service';

annotate prod.Products with @(


    odata.draft.enabled : true,
    Capabilities.InsertRestrictions.Insertable : true,
    Capabilities.UpdateRestrictions.Updatable : true,
    Capabilities.DeleteRestrictions.Deletable : true,

    UI: {
        HeaderInfo: {
            TypeName      : 'Produto',
            TypeNamePlural: 'Produtos',
            Title         : { Value: name },
            Description   : { Value: description },
            ImageUrl      : imagemUrl
        },

        DataPoint #RatingProduct: {
            $Type         : 'UI.DataPointType',
            Value         : rating,
            Title         : 'Avaliação Média',
            Visualization : #Rating,
            TargetValue   : 5,
        },

        DataPoint #PriceIndicator: {
            $Type         : 'UI.DataPointType',
            Value         : price,
            Title         : 'Preço Atual',
            Visualization : #Number,
        },

        DataPoint #StockIndicator: {
            $Type         : 'UI.DataPointType',
            Value         : stock,
            Title         : 'Estoque Atual',
            Visualization : #Number,
            //  Criticality   : {
            //     $Path: 'stock',
            //     $Apply: [
            //         { $If: [{ $Le: [{ $Path: 'stock' }, 10] }, 1] },  // Crítico (vermelho)
            //         { $If: [{ $Le: [{ $Path: 'stock' }, 50] }, 2] },  // Atenção (amarelo)
            //         3  // Normal (verde)
            //     ]
            // }
        },
        
        FieldGroup #GeneralInfo: {
            $Type: 'UI.FieldGroupType',
            Data : [
                { $Type: 'UI.DataField', Value: name},
                { $Type: 'UI.DataField', Value: description},
                { $Type: 'UI.DataField', Value: imagemUrl},
                { $Type: 'UI.DataField', Value: active},
                { $Type: 'UI.DataFieldForAnnotation', Target: '@UI.DataPoint#RatingProduct', Label: 'Avaliação' }
            ]
        },

        FieldGroup #PricingAndStock: {
            $Type: 'UI.FieldGroupType',
            Data : [
                { $Type: 'UI.DataField', Value: price },
                { $Type: 'UI.DataField', Value: stock},
                { $Type: 'UI.DataField', Value: currency_code,Label:'Moeda'},
                { $Type: 'UI.DataField', Value: measure_code,Label:'Medida'},
                { $Type: 'UI.DataField', Value: expirationDate}
            ]
        },

        FieldGroup #Associations: {
            $Type: 'UI.FieldGroupType',
            Data : [
                { $Type: 'UI.DataField', Value: category_ID, Label: 'Categoria' },
                { $Type: 'UI.DataField', Value: supplier_ID, Label: 'Fornecedor' }
            ]
        },

        FieldGroup #AuditInfo: {
            $Type: 'UI.FieldGroupType',
            Data : [
                { $Type: 'UI.DataField', Value: createdAt, Label: 'Criado em' },
                { $Type: 'UI.DataField', Value: createdBy, Label: 'Criado por' },
                { $Type: 'UI.DataField', Value: modifiedAt, Label: 'Modificado em' },
                { $Type: 'UI.DataField', Value: modifiedBy, Label: 'Modificado por' }
            ]
        },

        Facets: [
            {
                $Type : 'UI.CollectionFacet',
                ID    : 'ProductInfoCollection',
                Label : 'Dados do Produto',
                Facets: [
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
                        Label : 'Categoria e Fornecedor',
                        Target: '@UI.FieldGroup#Associations'
                    }
                ]
            },
            {
                $Type : 'UI.ReferenceFacet',
                ID    : 'AuditInfoFacet',
                Label : 'Auditoria',
                Target: '@UI.FieldGroup#AuditInfo'
            }
        ],

        LineItem: [
            { $Type: 'UI.DataField', Value: name },
            { $Type: 'UI.DataField', Value: category_name},
            { $Type: 'UI.DataField', Value: supplier_name},
            { $Type: 'UI.DataField', Value: price},
            { $Type: 'UI.DataField', Value: active },
            { $Type: 'UI.DataFieldForAnnotation', Target: '@UI.DataPoint#StockIndicator', Label: 'Estoque' },
            { $Type: 'UI.DataFieldForAnnotation', Target: '@UI.DataPoint#RatingProduct', Label: 'Avaliação' },
            { $Type: 'UI.DataFieldForAction', Action: 'prod.updateProductPrice', Label: 'Atualizar Preço' },
            { $Type: 'UI.DataFieldForAction', Action: 'prod.toggleProductStatus', Label: 'Ativar/Desativar', InvocationGrouping: #ChangeSet }
        ],

        SelectionFields : [
            name,
            category_name,
            supplier_name,
            price,
            stock,
            active,
            expirationDate
        ],

        HeaderFacets: [
            {
                $Type : 'UI.ReferenceFacet',
                ID    : 'PriceHeaderFacet',
                Target: '@UI.DataPoint#PriceIndicator'
            },
            {
                $Type : 'UI.ReferenceFacet',
                ID    : 'StockHeaderFacet',
                Target: '@UI.DataPoint#StockIndicator'
            },
            {
                $Type : 'UI.ReferenceFacet',
                ID    : 'RatingHeaderFacet',
                Target: '@UI.DataPoint#RatingProduct'
            },
]
    },

    Capabilities: {
        SearchRestrictions: {
            Searchable: true,
            UnsupportedExpressions: #phrase
        },
        FilterRestrictions: {
            Filterable: true,
            RequiredProperties: [],
            NonFilterableProperties: [imagemUrl]
        },
        SortRestrictions: {
            Sortable: true,
            AscendingOnlyProperties: [],
            DescendingOnlyProperties: [],
            NonSortableProperties: [imagemUrl]
        }
    }
);