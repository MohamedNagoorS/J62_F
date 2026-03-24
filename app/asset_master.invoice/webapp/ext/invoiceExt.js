sap.ui.define([
    "sap/m/MessageToast"
], function(MessageToast) {
    'use strict';

    return {
        downloadInvoice: function(oBindingContext, aSelectedContexts) {
            var aContexts = aSelectedContexts || [oBindingContext];
            if (!aContexts || aContexts.length === 0 || !aContexts[0]) {
                MessageToast.show("Please select an invoice.");
                return;
            }

            if (!window.jspdf || !window.jspdf.jsPDF) {
                MessageToast.show("PDF library not loaded.");
                return;
            }

            var oContext = aContexts[0];
            var oData = oContext.getObject();

            var doc = new window.jspdf.jsPDF();
            doc.text("Invoice Details", 14, 20);

            var bodyData = [
                ["ID", oData.invoiceID || oData.ID || ""],
                ["Supplier Invoice Number", oData.SupplierInvoiceNumber || ""],
                ["Fiscal Year", oData.FiscalYear || ""],
                ["Gross Amount", oData.GrossAmount || ""],
                ["Tax Code", oData.TaxCode || ""],
                ["Currency", oData.Currency || ""],
                ["Invoice Date", oData.InvoiceDate || ""],
                ["Posting Date", oData.PostingDate || ""],
                ["Goods Receipt ID", oData.refGoodsReceiptID || ""],
                ["Transaction Type", oData.TransactionType || ""]
            ];

            doc.autoTable({
                startY: 30,
                head: [["Field", "Value"]],
                body: bodyData,
                theme: 'grid',
                headStyles: { fillColor: [41, 128, 185], textColor: 255 },
                alternateRowStyles: { fillColor: [245, 245, 245] }
            });

            var sFileName = "Invoice_" + (oData.SupplierInvoiceNumber || oData.invoiceID || "Export") + ".pdf";
            doc.save(sFileName);
            MessageToast.show("Invoice downloaded successfully.");
        }
    };
});
