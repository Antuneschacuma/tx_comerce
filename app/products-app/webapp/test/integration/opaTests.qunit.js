sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'gestao/de/produtos/productsapp/test/integration/FirstJourney',
		'gestao/de/produtos/productsapp/test/integration/pages/ProductsList',
		'gestao/de/produtos/productsapp/test/integration/pages/ProductsObjectPage'
    ],
    function(JourneyRunner, opaJourney, ProductsList, ProductsObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('gestao/de/produtos/productsapp') + '/index.html'
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