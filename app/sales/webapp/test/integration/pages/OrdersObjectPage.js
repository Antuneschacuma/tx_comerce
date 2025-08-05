sap.ui.define(['sap/fe/test/ObjectPage'], function(ObjectPage) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ObjectPage(
        {
            appId: 'com.company.sales.sales',
            componentId: 'OrdersObjectPage',
            contextPath: '/Orders'
        },
        CustomPageDefinitions
    );
});