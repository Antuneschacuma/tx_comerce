using {sales.services.SalesService as sales} from '../../../srv/sales/sales-service';

// Value Helpers para Orders
annotate sales.Orders with {

    // Value Helper para Currency
    currency @(
        Common.Text.@UI.TextArrangement : #TextOnly,
        Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'Currency',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: currency_code,
                    ValueListProperty: 'code'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        }
    );

    // Dropdown para Status
    status @(
        Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'Orders',
            PresentationVariantQualifier: 'SortByStatus',
            Parameters: []
        },
        Common.ValueListWithFixedValues: false
        //[
        //     {
        //         Value: 'Pendente',
        //         Description: 'Aguardando processamento'
        //     },
        //     {
        //         Value: 'Processando', 
        //         Description: 'Em processamento'
        //     },
        //     {
        //         Value: 'Concluído',
        //         Description: 'Pedido finalizado'
        //     },
        //     {
        //         Value: 'Cancelado',
        //         Description: 'Pedido cancelado'
        //     }
        // ]
    );
};

// Value Helpers para OrderItems (MAIS IMPORTANTE)
annotate sales.OrderItems with {

    // Value Helper para Produto - Este é o principal!
    product @(
        Common.Text: product.name,
        Common.TextArrangement: #TextLast,
        Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'Products',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: product_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'price'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'stock'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'active'
                }
            ],
            // Filtros adicionais para mostrar só produtos ativos
        //     SelectionVariant: {
        //         $Type: 'Common.SelectionVariantType',
        //         SelectOptions: [
        //             {
        //                 PropertyName: 'active',
        //                 Ranges: [
        //                     {
        //                         Sign: #I,
        //                         Option: #EQ,
        //                         Low: true
        //                     }
        //                 ]
        //             }
        //         ]
        //     }
        }
    );

    // Campo de observação como multi-line
    observation @(
        UI.MultiLineText: true
    );

    // Validações e constraints
    quantity @(
        Common.FieldControl: #Mandatory,
        Validation.Minimum: 1
    );

    unitPrice @(
        Common.FieldControl: #ReadOnly  // Será preenchido automaticamente
    );

    totalPrice @(
        Common.FieldControl: #ReadOnly  // Será calculado automaticamente
    );
};