sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"assetmaster/goodsreceipt/test/integration/pages/GoodsReceiptList",
	"assetmaster/goodsreceipt/test/integration/pages/GoodsReceiptObjectPage"
], function (JourneyRunner, GoodsReceiptList, GoodsReceiptObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('assetmaster/goodsreceipt') + '/test/flpSandbox.html#assetmastergoodsreceipt-tile',
        pages: {
			onTheGoodsReceiptList: GoodsReceiptList,
			onTheGoodsReceiptObjectPage: GoodsReceiptObjectPage
        },
        async: true
    });

    return runner;
});

