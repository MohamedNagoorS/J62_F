sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"assetmaster/purchaseorder/test/integration/pages/PurchaseOrderList",
	"assetmaster/purchaseorder/test/integration/pages/PurchaseOrderObjectPage"
], function (JourneyRunner, PurchaseOrderList, PurchaseOrderObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('assetmaster/purchaseorder') + '/test/flpSandbox.html#assetmasterpurchaseorder-tile',
        pages: {
			onThePurchaseOrderList: PurchaseOrderList,
			onThePurchaseOrderObjectPage: PurchaseOrderObjectPage
        },
        async: true
    });

    return runner;
});

