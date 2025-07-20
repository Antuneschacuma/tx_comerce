sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'tx/commerce/product/products/test/integration/FirstJourney',
		'tx/commerce/product/products/test/integration/pages/ProductsList',
		'tx/commerce/product/products/test/integration/pages/ProductsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductsList, ProductsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('tx/commerce/product/products') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheProductsList: ProductsList,
					onTheProductsObjectPage: ProductsObjectPage
                }
            },
            opaJourney.run
        );
    }
);