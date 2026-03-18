sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner"
], function (opaTest, runner) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onThePurchaseRequisitionList.iSeeThisPage();
            Then.onThePurchaseRequisitionList.onFilterBar().iCheckFilterField("ID");
            Then.onThePurchaseRequisitionList.onTable().iCheckColumns(9, {"purchaseRequisitionID":{"header":"ID"},"AccountAssignmentCategory":{"header":"Account Assignment Category"},"ShortText":{"header":"Short Text"},"Quantity":{"header":"Quantity"},"UnitOfMeasure":{"header":"Unit Of Measure"},"MaterialGroup":{"header":"Material Group"},"Plant":{"header":"Plant"},"ValuationPrice":{"header":"Valuation Price"},"refPurchaseOrderID":{"header":"refPurchaseOrderID"}});

        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onThePurchaseRequisitionList.onFilterBar().iExecuteSearch();
            
            Then.onThePurchaseRequisitionList.onTable().iCheckRows();

            When.onThePurchaseRequisitionList.onTable().iPressRow(0);
            Then.onThePurchaseRequisitionObjectPage.iSeeThisPage();

        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});