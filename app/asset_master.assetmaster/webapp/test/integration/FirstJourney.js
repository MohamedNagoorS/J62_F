sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner"
], function (opaTest, runner) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onTheAssetMasterList.iSeeThisPage();
            Then.onTheAssetMasterList.onFilterBar().iCheckFilterField("ID");
            Then.onTheAssetMasterList.onTable().iCheckColumns(7, {"assetMasterID":{"header":"ID"},"AssetClass":{"header":"Asset Class"},"Description":{"header":"Description"},"CompanyCode":{"header":"Company Code"},"CostCenter":{"header":"Cost Center"},"CapitalizedOn":{"header":"Capitalized On"},"refPurchaseRequisitionID":{"header":"refPurchaseRequisitionID"}});

        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onTheAssetMasterList.onFilterBar().iExecuteSearch();
            
            Then.onTheAssetMasterList.onTable().iCheckRows();

            When.onTheAssetMasterList.onTable().iPressRow(0);
            Then.onTheAssetMasterObjectPage.iSeeThisPage();

        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});