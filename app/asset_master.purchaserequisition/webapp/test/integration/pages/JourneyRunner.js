sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"assetmaster/purchaserequisition/test/integration/pages/PurchaseRequisitionList",
	"assetmaster/purchaserequisition/test/integration/pages/PurchaseRequisitionObjectPage"
], function (JourneyRunner, PurchaseRequisitionList, PurchaseRequisitionObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('assetmaster/purchaserequisition') + '/test/flpSandbox.html#assetmasterpurchaserequisition-tile',
        pages: {
			onThePurchaseRequisitionList: PurchaseRequisitionList,
			onThePurchaseRequisitionObjectPage: PurchaseRequisitionObjectPage
        },
        async: true
    });

    return runner;
});

