sap.ui.require(
    [
        'sap/fe/test/JourneyRunner',
        'com/company/sales/sales/test/integration/FirstJourney',
		'com/company/sales/sales/test/integration/pages/OrdersList',
		'com/company/sales/sales/test/integration/pages/OrdersObjectPage'
    ],
    function(JourneyRunner, opaJourney, OrdersList, OrdersObjectPage) {
        'use strict';
        var JourneyRunner = new JourneyRunner({
            // start index.html in web folder
            launchUrl: sap.ui.require.toUrl('com/company/sales/sales') + '/index.html'
        });

       
        JourneyRunner.run(
            {
                pages: { 
					onTheOrdersList: OrdersList,
					onTheOrdersObjectPage: OrdersObjectPage
                }
            },
            opaJourney.run
        );
    }
);