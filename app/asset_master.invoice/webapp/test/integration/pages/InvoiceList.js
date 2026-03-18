sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'assetmaster.invoice',
            componentId: 'InvoiceList',
            contextPath: '/Invoice'
        },
        CustomPageDefinitions
    );
});