sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner"
], function (opaTest, runner) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onTheGoodsReceiptList.iSeeThisPage();
            Then.onTheGoodsReceiptList.onFilterBar().iCheckFilterField("ID");
            Then.onTheGoodsReceiptList.onTable().iCheckColumns(4, {"goodsReceiptID":{"header":"ID"},"MaterialDocument":{"header":"Material Document"},"PostingDate":{"header":"Posting Date"},"refInvoiceID":{"header":"refInvoiceID"}});

        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onTheGoodsReceiptList.onFilterBar().iExecuteSearch();
            
            Then.onTheGoodsReceiptList.onTable().iCheckRows();

            When.onTheGoodsReceiptList.onTable().iPressRow(0);
            Then.onTheGoodsReceiptObjectPage.iSeeThisPage();

        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});