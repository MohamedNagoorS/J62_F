sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"assetmaster/assetmaster/test/integration/pages/AssetMasterList",
	"assetmaster/assetmaster/test/integration/pages/AssetMasterObjectPage"
], function (JourneyRunner, AssetMasterList, AssetMasterObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('assetmaster/assetmaster') + '/test/flpSandbox.html#assetmasterassetmaster-tile',
        pages: {
			onTheAssetMasterList: AssetMasterList,
			onTheAssetMasterObjectPage: AssetMasterObjectPage
        },
        async: true
    });

    return runner;
});

