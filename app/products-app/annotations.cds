using {products.services.ProductService as prod} from '../../srv/products/products-service';

// ==========================================
// ANOTAÇÕES GERAIS DE UI - PRODUTOS
// ==========================================

annotate prod.Products with @(
    odata.draft.enabled : true,
    Capabilities.InsertRestrictions.Insertable : true,
    Capabilities.UpdateRestrictions.Updatable : true,
    Capabilities.DeleteRestrictions.Deletable : true,

    UI: {
        // === CABEÇALHO DA ENTIDADE ===
        HeaderInfo: {
            TypeName      : 'Produto',
            TypeNamePlural: 'Produtos',
            Title         : { Value: name },
            Description   : { Value: description },
            ImageUrl      : imagemUrl
        },

        // === INDICADOR DE AVALIAÇÃO ===
        DataPoint #RatingProduct: {
            $Type         : 'UI.DataPointType',
            Value         : rating,
            Title         : 'Avaliação Média',
            Visualization : #Rating,
            TargetValue   : 5,
        },

        // === INDICADOR DE PREÇO ===
        DataPoint #PriceIndicator: {
            $Type         : 'UI.DataPointType',
            Value         : price,
            Title         : 'Preço Atual',
            Visualization : #Number,
        },

        // === INDICADOR DE ESTOQUE ===
        DataPoint #StockIndicator: {
            $Type         : 'UI.DataPointType',
            Value         : stock,
            Title         : 'Estoque Atual',
            Visualization : #Number,
            // Criticality   : {
            //     $Path: 'stock',
            //     $Apply: [
            //         { $If: [{ $Le: [{ $Path: 'stock' }, 10] }, 1] },  // Crítico (vermelho)
            //         { $If: [{ $Le: [{ $Path: 'stock' }, 50] }, 2] },  // Atenção (amarelo)
            //         3  // Normal (verde)
            //     ]
            // }
        },

        // === AGRUPAMENTOS DE CAMPOS ===
        
        FieldGroup #GeneralInfo: {
            $Type: 'UI.FieldGroupType',
            Label: 'Informações Básicas',
            Data : [
                { $Type: 'UI.DataField', Value: name, Label: 'Nome do Produto' },
                { $Type: 'UI.DataField', Value: description, Label: 'Descrição' },
                { $Type: 'UI.DataField', Value: imagemUrl, Label: 'URL da Imagem' },
                { $Type: 'UI.DataField', Value: active, Label: 'Produto Ativo' },
                { $Type: 'UI.DataFieldForAnnotation', Target: '@UI.DataPoint#RatingProduct', Label: 'Avaliação' }
            ]
        },

        FieldGroup #PricingAndStock: {
            $Type: 'UI.FieldGroupType',
            Label: 'Preço e Estoque',
            Data : [
                { $Type: 'UI.DataField', Value: price, Label: 'Preço Unitário' },
                { $Type: 'UI.DataField', Value: currency_code, Label: 'Moeda' },
                { $Type: 'UI.DataField', Value: stock, Label: 'Quantidade em Estoque' },
                { $Type: 'UI.DataField', Value: measure_code, Label: 'Unidade de Medida' },
                { $Type: 'UI.DataField', Value: expirationDate, Label: 'Data de Validade' }
            ]
        },

        FieldGroup #Associations: {
            $Type: 'UI.FieldGroupType',
            Label: 'Relacionamentos',
            Data : [
                { $Type: 'UI.DataField', Value: category_ID, Label: 'Categoria' },
                { $Type: 'UI.DataField', Value: supplier_ID, Label: 'Fornecedor' }
            ]
        },

        FieldGroup #AuditInfo: {
            $Type: 'UI.FieldGroupType',
            Label: 'Informações de Auditoria',
            Data : [
                { $Type: 'UI.DataField', Value: createdAt, Label: 'Criado em' },
                { $Type: 'UI.DataField', Value: createdBy, Label: 'Criado por' },
                { $Type: 'UI.DataField', Value: modifiedAt, Label: 'Modificado em' },
                { $Type: 'UI.DataField', Value: modifiedBy, Label: 'Modificado por' }
            ]
        },

        // === ABAS DO FORMULÁRIO (OBJECT PAGE) ===
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

        // === COLUNAS DA TABELA/LISTA (LIST REPORT) ===
          LineItem: [
            { $Type: 'UI.DataField', Value: name },
            { $Type: 'UI.DataField', Value: category_name},
            { $Type: 'UI.DataField', Value: supplier_name},
            { $Type: 'UI.DataField', Value: price},
            // { $Type: 'UI.DataFieldForAnnotation', Target: '@UI.DataPoint#StockIndicator', Label: 'Estoque' },
            { $Type: 'UI.DataFieldForAction', Action: 'prod.updateProductPrice', Label: 'Atualizar Preço' },
            { $Type: 'UI.DataFieldForAction', Action: 'prod.toggleProductStatus', Label: 'Ativar/Desativar', InvocationGrouping: #ChangeSet },
            { $Type: 'UI.DataFieldForAnnotation', Target: '@UI.DataPoint#RatingProduct', Label: 'Avaliação' }
        ],

        // === FILTROS DISPONÍVEIS (FILTER BAR) ===
        SelectionFields : [
            name,
            category_name,
            supplier_name,
            currency_code,
            price,
            stock,
            active,
            expirationDate
        ],

        // === CABEÇALHO COM INDICADORES ===
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
            }
        ]
    },

    // === RESTRIÇÕES DE INSERÇÃO/EDIÇÃO ===
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
annotate prod.Products with {
    category @(
        Common.Text : category_name,
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'Categories',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : ID,
                    ValueListProperty : 'ID',
                },
            ],
        },
    )
};

