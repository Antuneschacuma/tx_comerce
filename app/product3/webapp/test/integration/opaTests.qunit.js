sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'tx/commerce/product3/product3/test/integration/FirstJourney',
		'tx/commerce/product3/product3/test/integration/pages/ProductsList',
		'tx/commerce/product3/product3/test/integration/pages/ProductsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductsList, ProductsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('tx/commerce/product3/product3') + '/index.html'
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