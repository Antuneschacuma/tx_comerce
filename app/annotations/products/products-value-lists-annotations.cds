
using {products.services.ProductService as prod} from '../../../srv/products/products-service';



// Value Helpers otimizados
annotate prod.Products with {
    category @(
        Common.Text: category.name,
        Common.TextArrangement : #TextOnly,
        Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'Categories',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: category_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'description'
                }
            ]
        }
    );

    category_name @(
        Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'Categories',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: category_name,
                    ValueListProperty: 'name'
                }
            ]
        }
    );

    supplier @(
        Common.Text: supplier.name,
        Common.TextArrangement : #TextOnly,
        Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'Suppliers',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: supplier_ID,
                    ValueListProperty: 'ID'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'contact'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'email'
                }
            ]
        }
    );

    supplier_name @(
        Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'Suppliers',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: supplier_name,
                    ValueListProperty: 'name'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'contact'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'email'
                }
            ]
        }
    );

    currency @(
        Common.Text: currency.name,
        Common.TextArrangement : #TextOnly,
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

    measure @(
        Common.Text: measure.name,
        Common.TextArrangement : #TextOnly,
        Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'UnitMeasurement',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: measure_code,
                    ValueListProperty: 'code'
                },
                {
                    $Type: 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty: 'name'
                }
            ]
        }
    );


    stock @(
        Common.Text: measure.name,
        Common.TextArrangement : #TextOnly,
        Common.ValueList: {
            $Type: 'Common.ValueListType',
            CollectionPath: 'Products',
            Parameters: [
                {
                    $Type: 'Common.ValueListParameterInOut',
                    LocalDataProperty: stock,
                    ValueListProperty: 'stock'
                },
                // {
                //     $Type: 'Common.ValueListParameterDisplayOnly',
                //     ValueListProperty: 'name'
                // }
            ]
        }
    );

    description @(
        UI.MultiLineText: true
    );

    imagemUrl @(
        UI.IsImageURL: true
    );

    // Validações adicionais
    price @(
        Common.FieldControl: #Mandatory,
        Measures.ISOCurrency: currency_code
    );

    stock @(
        Common.FieldControl: #Mandatory,
        Validation.Minimum: 0
    );

    // expirationDate @(
    //     Common.FieldControl: {
    //         $edmJson: {
    //             $If: [
    //                 { $Ne: [{ $Path: 'category_name' }, 'Perecível'] },
    //                 1,  // ReadOnly se não for perecível
    //                 7   // Mandatory se for perecível
    //             ]
    //         }
    //     }
    // );
};




