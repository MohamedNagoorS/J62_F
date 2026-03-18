sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"assetmaster/invoice/test/integration/pages/InvoiceList",
	"assetmaster/invoice/test/integration/pages/InvoiceObjectPage"
], function (JourneyRunner, InvoiceList, InvoiceObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('assetmaster/invoice') + '/test/flpSandbox.html#assetmasterinvoice-tile',
        pages: {
			onTheInvoiceList: InvoiceList,
			onTheInvoiceObjectPage: InvoiceObjectPage
        },
        async: true
    });

    return runner;
});

