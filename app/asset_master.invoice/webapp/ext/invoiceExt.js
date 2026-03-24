sap.ui.define([
    "sap/m/MessageToast",
    "./images"
], function(MessageToast, Images) {
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
            var doc = new window.jspdf.jsPDF({ orientation: 'portrait', unit: 'mm', format: 'a4' });
            var pageW = 210;
            var pageH = 297;
            var margin = 14;
            var contentW = pageW - margin * 2;

            // ── HEADER BANNER ──────────────────────────────────
            if (Images && Images.header) {
                doc.addImage(Images.header, 'JPEG', 0, 0, pageW, 18);
            } else {
                doc.setFillColor(0, 51, 102);
                doc.rect(0, 0, pageW, 18, 'F');
            }

            // ── COMPANY TITLE IN HEADER ────────────────────────
            doc.setFontSize(11);
            doc.setTextColor(255, 255, 255);
            doc.setFont(undefined, 'bold');
            doc.text("SAP S/4HANA | Asset Accounting | J62", margin, 7);
            doc.setFontSize(9);
            doc.setFont(undefined, 'normal');
            doc.text("Supplier Invoice Document", margin, 13);

            // ── DOCUMENT TITLE BLOCK ───────────────────────────
            doc.setFillColor(245, 247, 250);
            doc.rect(0, 18, pageW, 22, 'F');

            doc.setFontSize(20);
            doc.setTextColor(0, 51, 102);
            doc.setFont(undefined, 'bold');
            doc.text("SUPPLIER INVOICE", margin, 31);

            // Status badge
            doc.setFillColor(232, 244, 232);
            doc.roundedRect(pageW - margin - 28, 22, 28, 8, 2, 2, 'F');
            doc.setFontSize(8);
            doc.setTextColor(46, 125, 50);
            doc.setFont(undefined, 'bold');
            doc.text("POSTED", pageW - margin - 22, 27.5);

            // ── DIVIDER ────────────────────────────────────────
            doc.setDrawColor(0, 51, 102);
            doc.setLineWidth(0.8);
            doc.line(margin, 41, pageW - margin, 41);

            // ── INVOICE REFERENCE BOX ──────────────────────────
            doc.setFillColor(0, 51, 102);
            doc.rect(margin, 44, contentW, 8, 'F');
            doc.setFontSize(9);
            doc.setTextColor(255, 255, 255);
            doc.setFont(undefined, 'bold');
            doc.text("Invoice No: " + (oData.invoiceID || "-"), margin + 3, 49.5);
            doc.text("Ref: " + (oData.SupplierInvoiceNumber || "-"), margin + 60, 49.5);
            doc.text("Fiscal Year: " + (oData.FiscalYear || "-"), margin + 120, 49.5);

            // ── SECTION 1: INVOICE DETAILS ─────────────────────
            var y = 62;

            // Section header
            doc.setFillColor(0, 51, 102);
            doc.rect(margin, y, contentW, 7, 'F');
            doc.setFontSize(10);
            doc.setTextColor(255, 255, 255);
            doc.setFont(undefined, 'bold');
            doc.text("Invoice Details", margin + 3, y + 5);
            y += 7;

            // Detail rows with alternating background
            var fields = [
                ["Transaction Type", (oData.TransactionType || "-"), "Invoice Date", (oData.InvoiceDate || "-")],
                ["Supplier Invoice No.", (oData.SupplierInvoiceNumber || "-"), "Posting Date", (oData.PostingDate || "-")],
                ["Fiscal Year", (oData.FiscalYear || "-"), "GR Reference", (oData.refGoodsReceiptID || "-")],
                ["Posted By", (oData.PostedBy || "-"), "Reference", (oData.Reference || "-")]
            ];

            fields.forEach(function(row, i) {
                if (i % 2 === 0) {
                    doc.setFillColor(248, 250, 252);
                    doc.rect(margin, y, contentW, 9, 'F');
                } else {
                    doc.setFillColor(255, 255, 255);
                    doc.rect(margin, y, contentW, 9, 'F');
                }

                // Left label
                doc.setFontSize(8);
                doc.setTextColor(100, 100, 100);
                doc.setFont(undefined, 'normal');
                doc.text(row[0], margin + 3, y + 4);
                // Left value
                doc.setFontSize(9);
                doc.setTextColor(0, 0, 0);
                doc.setFont(undefined, 'bold');
                doc.text(row[1].toString(), margin + 3, y + 8);

                // Right label
                doc.setFontSize(8);
                doc.setTextColor(100, 100, 100);
                doc.setFont(undefined, 'normal');
                doc.text(row[2], margin + 95, y + 4);
                // Right value
                doc.setFontSize(9);
                doc.setTextColor(0, 0, 0);
                doc.setFont(undefined, 'bold');
                doc.text(row[3].toString(), margin + 95, y + 8);

                // Row bottom border
                doc.setDrawColor(220, 220, 220);
                doc.setLineWidth(0.2);
                doc.line(margin, y + 9, pageW - margin, y + 9);

                y += 9;
            });

            y += 8;

            // ── SECTION 2: FINANCIAL DETAILS ───────────────────

            // Section header
            doc.setFillColor(0, 51, 102);
            doc.rect(margin, y, contentW, 7, 'F');
            doc.setFontSize(10);
            doc.setTextColor(255, 255, 255);
            doc.setFont(undefined, 'bold');
            doc.text("Financial Details", margin + 3, y + 5);
            y += 7;

            // Table header row
            doc.setFillColor(230, 235, 245);
            doc.rect(margin, y, contentW, 8, 'F');
            doc.setFontSize(9);
            doc.setTextColor(0, 51, 102);
            doc.setFont(undefined, 'bold');
            doc.text("Description", margin + 3, y + 5.5);
            doc.text("Currency", margin + 80, y + 5.5);
            doc.text("Tax Code", margin + 110, y + 5.5);
            doc.text("Gross Amount", margin + 140, y + 5.5);
            y += 8;

            // Table data row
            doc.setFillColor(248, 250, 252);
            doc.rect(margin, y, contentW, 9, 'F');
            doc.setFontSize(9);
            doc.setTextColor(0, 0, 0);
            doc.setFont(undefined, 'normal');
            doc.text((oData.SupplierInvoiceNumber || "Supplier Invoice").toString(), margin + 3, y + 6);
            doc.text((oData.Currency || "EUR").toString(), margin + 80, y + 6);
            doc.text((oData.TaxCode || "-").toString(), margin + 110, y + 6);
            doc.setFont(undefined, 'bold');
            doc.text(parseFloat(oData.GrossAmount || 0).toFixed(2).toString(), margin + 140, y + 6);
            doc.setDrawColor(220, 220, 220);
            doc.setLineWidth(0.2);
            doc.line(margin, y + 9, pageW - margin, y + 9);
            y += 9;

            // ── TOTALS BOX ─────────────────────────────────────
            y += 5;
            doc.setFillColor(0, 51, 102);
            doc.rect(pageW - margin - 75, y, 75, 28, 'F');

            doc.setFontSize(9);
            doc.setTextColor(200, 210, 230);
            doc.setFont(undefined, 'normal');
            doc.text("Net Amount:", pageW - margin - 72, y + 7);
            doc.setTextColor(255, 255, 255);
            doc.text((oData.Currency || "EUR") + " " + parseFloat(oData.GrossAmount || 0).toFixed(2), pageW - margin - 5, y + 7, { align: 'right' });

            doc.setTextColor(200, 210, 230);
            doc.text("Tax (" + (oData.TaxCode || "-") + "):", pageW - margin - 72, y + 15);
            doc.setTextColor(255, 255, 255);
            doc.text("Included", pageW - margin - 5, y + 15, { align: 'right' });

            doc.setDrawColor(100, 140, 200);
            doc.setLineWidth(0.3);
            doc.line(pageW - margin - 72, y + 18, pageW - margin - 2, y + 18);

            doc.setFontSize(11);
            doc.setFont(undefined, 'bold');
            doc.setTextColor(255, 255, 255);
            doc.text("TOTAL:", pageW - margin - 72, y + 25);
            doc.text((oData.Currency || "EUR") + " " + parseFloat(oData.GrossAmount || 0).toFixed(2), pageW - margin - 5, y + 25, { align: 'right' });

            y += 38;

            // ── SECTION 3: GOODS RECEIPT ───────────────────────
            if (oData.refGoodsReceiptID) {
                doc.setFillColor(0, 51, 102);
                doc.rect(margin, y, contentW, 7, 'F');
                doc.setFontSize(10);
                doc.setTextColor(255, 255, 255);
                doc.setFont(undefined, 'bold');
                doc.text("Goods Receipt Reference", margin + 3, y + 5);
                y += 7;

                doc.setFillColor(248, 250, 252);
                doc.rect(margin, y, contentW, 18, 'F');
                doc.setDrawColor(220, 220, 220);
                doc.setLineWidth(0.2);
                doc.rect(margin, y, contentW, 18);

                doc.setFontSize(8);
                doc.setTextColor(100, 100, 100);
                doc.setFont(undefined, 'normal');
                doc.text("GR Reference ID", margin + 3, y + 5);
                doc.text("Linked Invoice", margin + 60, y + 5);

                doc.setFontSize(10);
                doc.setTextColor(0, 0, 0);
                doc.setFont(undefined, 'bold');
                doc.text(oData.refGoodsReceiptID.toString(), margin + 3, y + 13);
                doc.text((oData.invoiceID || "-").toString(), margin + 60, y + 13);

                y += 25;
            }

            // ── DISCLAIMER ─────────────────────────────────────
            doc.setFontSize(7);
            doc.setTextColor(150, 150, 150);
            doc.setFont(undefined, 'italic');
            doc.text("This document was automatically generated by SAP S/4HANA Asset Accounting (J62). For official purposes only.", margin, y);
            doc.text("Generated: " + new Date().toLocaleDateString('en-US', { year: 'numeric', month: 'long', day: 'numeric' }), margin, y + 5);

            // ── FOOTER BANNER ──────────────────────────────────
            if (Images && Images.header) {
                doc.addImage(Images.header, 'JPEG', 0, pageH - 14, pageW, 14);
            } else {
                doc.setFillColor(0, 51, 102);
                doc.rect(0, pageH - 14, pageW, 14, 'F');
            }

            doc.setFontSize(8);
            doc.setTextColor(255, 255, 255);
            doc.setFont(undefined, 'normal');
            doc.text("SAP S/4HANA Asset Accounting | J62 Asset Accounting Module", margin, pageH - 7);
            doc.text("Page 1 of 1", pageW - margin, pageH - 7, { align: 'right' });

            // ── SAVE ───────────────────────────────────────────
            var sFileName = "Invoice_" + (oData.SupplierInvoiceNumber || oData.invoiceID || "Export") + ".pdf";
            doc.save(sFileName);
            MessageToast.show("Invoice downloaded: " + sFileName);
        }
    };
});