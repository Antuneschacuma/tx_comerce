sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'com.company.sales.sales',
            componentId: 'OrdersList',
            contextPath: '/Orders'
        },
        CustomPageDefinitions
    );
});