using {products.services.ProductService as prod} from '../../../srv/products/products-service';

annotate prod.Products with {

    category @(
           Common.Text.@UI.TextArrangement : #TextOnly,
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
                },
            ]
        }
    );

    supplier @(
          Common.Text.@UI.TextArrangement : #TextOnly,
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

    measure @(
         Common.Text.@UI.TextArrangement : #TextOnly,
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
                },
            ]
        }
    );

    description @(
        UI.MultiLineText: true
    );

    imagemUrl @(
        UI.IsImageURL: true
    );

};
