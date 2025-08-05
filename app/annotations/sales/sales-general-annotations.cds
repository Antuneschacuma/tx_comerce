using {sales.services.SalesService as sales} from '../../../srv/sales/sales-service';

annotate sales.Orders with @(
    odata.draft.enabled : true,
    Capabilities.InsertRestrictions.Insertable : true,
    Capabilities.UpdateRestrictions.Updatable : true,
    Capabilities.DeleteRestrictions.Deletable : true,

    UI: {
        HeaderInfo: {
            TypeName      : 'Pedido',
            TypeNamePlural: 'Pedidos',
            Title         : { Value: ID },
            Description   : { Value: status },
        },

        DataPoint #TotalAmount: {
            $Type         : 'UI.DataPointType',
            Value         : totalAmount,
            Title         : 'Valor Total',
            Visualization : #Number,
        },

        DataPoint #StatusIndicator: {
            $Type         : 'UI.DataPointType', 
            Value         : status,
            Title         : 'Status do Pedido',
        //     Visualization : #Text,
        //     Criticality   : {
        //         $Type: 'UI.CriticalityType',
        //         $Value: {
        //             $If: [
        //                 { $Eq: [{ $Path: 'status' }, 'Pendente'] }, 2,
        //                 { $If: [{ $Eq: [{ $Path: 'status' }, 'Processando'] }, 3,
        //                   { $If: [{ $Eq: [{ $Path: 'status' }, 'Concluído'] }, 1, 0] }
        //                 ] }
        //             ]
        //         }
        //     }
        },

        FieldGroup #OrderInfo: {
            $Type: 'UI.FieldGroupType',
            Data : [
                { $Type: 'UI.DataField', Value: orderDate, Label: 'Data do Pedido' },
                { $Type: 'UI.DataField', Value: status, Label: 'Status' },
                { $Type: 'UI.DataField', Value: totalAmount, Label: 'Valor Total' },
                { $Type: 'UI.DataField', Value: currency_code, Label: 'Moeda' }
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
                $Type : 'UI.ReferenceFacet',
                ID    : 'OrderInfoFacet',
                Label : 'Informações do Pedido',
                Target: '@UI.FieldGroup#OrderInfo'
            },
            {
                $Type : 'UI.ReferenceFacet',
                ID    : 'OrderItemsFacet',
                Label : 'Itens do Pedido',
                Target: 'items/@UI.LineItem'
            },
            {
                $Type : 'UI.ReferenceFacet',
                ID    : 'AuditInfoFacet',
                Label : 'Auditoria',
                Target: '@UI.FieldGroup#AuditInfo'
            }
        ],

        LineItem: [
            { $Type: 'UI.DataField', Value: ID, Label: 'Nº Pedido' },
            { $Type: 'UI.DataField', Value: orderDate, Label: 'Data' },
            { $Type: 'UI.DataFieldForAnnotation', Target: '@UI.DataPoint#StatusIndicator', Label: 'Status' },
            { $Type: 'UI.DataFieldForAnnotation', Target: '@UI.DataPoint#TotalAmount', Label: 'Valor Total' },
            { $Type: 'UI.DataField', Value: currency_code, Label: 'Moeda' }
        ],

        SelectionFields : [
            orderDate,
            status,
            totalAmount
        ],

        HeaderFacets: [
            {
                $Type : 'UI.ReferenceFacet',
                ID    : 'TotalAmountHeaderFacet',
                Target: '@UI.DataPoint#TotalAmount'
            },
            {
                $Type : 'UI.ReferenceFacet',
                ID    : 'StatusHeaderFacet',
                Target: '@UI.DataPoint#StatusIndicator'
            }
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
            NonFilterableProperties: []
        },
        SortRestrictions: {
            Sortable: true,
            AscendingOnlyProperties: [],
            DescendingOnlyProperties: [],
            NonSortableProperties: []
        }
    }
);

// Anotações para OrderItems
annotate sales.OrderItems with @(
    UI: {
        HeaderInfo: {
            TypeName      : 'Item',
            TypeNamePlural: 'Itens',
            Title         : { Value: product.name },
            Description   : { Value: observation }
        },

        LineItem: [
            { $Type: 'UI.DataField', Value: product_ID, Label: 'Produto' },
            { $Type: 'UI.DataField', Value: quantity, Label: 'Quantidade' },
            { $Type: 'UI.DataField', Value: unitPrice, Label: 'Preço Unitário' },
            { $Type: 'UI.DataField', Value: totalPrice, Label: 'Total Item' },
            { $Type: 'UI.DataField', Value: observation, Label: 'Observações' }
        ],

        FieldGroup #ItemDetails: {
            $Type: 'UI.FieldGroupType',
            Data : [
                { $Type: 'UI.DataField', Value: product_ID, Label: 'Produto' },
                { $Type: 'UI.DataField', Value: quantity, Label: 'Quantidade' },
                { $Type: 'UI.DataField', Value: unitPrice, Label: 'Preço Unitário' },
                { $Type: 'UI.DataField', Value: totalPrice, Label: 'Total do Item' },
                { $Type: 'UI.DataField', Value: observation, Label: 'Observações' }
            ]
        },

        Facets: [
            {
                $Type : 'UI.ReferenceFacet',
                ID    : 'ItemDetailsFacet',
                Label : 'Detalhes do Item',
                Target: '@UI.FieldGroup#ItemDetails'
            }
        ]
    }
);