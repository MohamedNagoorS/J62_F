sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner"
], function (opaTest, runner) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onThePurchaseOrderList.iSeeThisPage();
            Then.onThePurchaseOrderList.onFilterBar().iCheckFilterField("ID");
            Then.onThePurchaseOrderList.onTable().iCheckColumns(6, {"purchaseOrderID":{"header":"ID"},"PurchaseOrderType":{"header":"Purchase Order Type"},"Supplier":{"header":"Supplier"},"OrderQuantity":{"header":"Order Quantity"},"NetPrice":{"header":"Net Price"},"refGoodsReceiptID":{"header":"refGoodsReceiptID"}});

        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onThePurchaseOrderList.onFilterBar().iExecuteSearch();
            
            Then.onThePurchaseOrderList.onTable().iCheckRows();

            When.onThePurchaseOrderList.onTable().iPressRow(0);
            Then.onThePurchaseOrderObjectPage.iSeeThisPage();

        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});