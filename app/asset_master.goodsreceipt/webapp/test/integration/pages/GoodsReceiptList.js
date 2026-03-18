sap.ui.define(['sap/fe/test/ListReport'], function(ListReport) {
    'use strict';

    var CustomPageDefinitions = {
        actions: {},
        assertions: {}
    };

    return new ListReport(
        {
            appId: 'assetmaster.goodsreceipt',
            componentId: 'GoodsReceiptList',
            contextPath: '/GoodsReceipt'
        },
        CustomPageDefinitions
    );
});