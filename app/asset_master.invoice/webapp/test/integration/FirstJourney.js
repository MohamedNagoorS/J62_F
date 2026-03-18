sap.ui.define([
    "sap/ui/test/opaQunit",
    "./pages/JourneyRunner"
], function (opaTest, runner) {
    "use strict";

    function journey() {
        QUnit.module("First journey");

        opaTest("Start application", function (Given, When, Then) {
            Given.iStartMyApp();

            Then.onTheInvoiceList.iSeeThisPage();
            Then.onTheInvoiceList.onFilterBar().iCheckFilterField("ID");
            Then.onTheInvoiceList.onTable().iCheckColumns(5, {"invoiceID":{"header":"ID"},"SupplierInvoiceNumber":{"header":"Supplier Invoice Number"},"FiscalYear":{"header":"Fiscal Year"},"GrossAmount":{"header":"Gross Amount"},"TaxCode":{"header":"Tax Code"}});

        });


        opaTest("Navigate to ObjectPage", function (Given, When, Then) {
            // Note: this test will fail if the ListReport page doesn't show any data
            
            When.onTheInvoiceList.onFilterBar().iExecuteSearch();
            
            Then.onTheInvoiceList.onTable().iCheckRows();

            When.onTheInvoiceList.onTable().iPressRow(0);
            Then.onTheInvoiceObjectPage.iSeeThisPage();

        });

        opaTest("Teardown", function (Given, When, Then) { 
            // Cleanup
            Given.iTearDownMyApp();
        });
    }

    runner.run([journey]);
});