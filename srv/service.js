const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    this.before('CREATE', 'AssetMaster', async (req) => {
        if (!req.data.assetMasterID) {
            const { AssetMaster } = this.entities;
            const result = await SELECT.one.from(AssetMaster).columns('assetMasterID').orderBy({ assetMasterID: 'desc' });
            req.data.assetMasterID = result && result.assetMasterID ? result.assetMasterID + 1 : 100001;
        }
    });

    this.before('CREATE', 'PurchaseRequisition', async (req) => {
        if (!req.data.purchaseRequisitionID) {
            const { PurchaseRequisition } = this.entities;
            const result = await SELECT.one.from(PurchaseRequisition).columns('purchaseRequisitionID').orderBy({ purchaseRequisitionID: 'desc' });
            req.data.purchaseRequisitionID = result && result.purchaseRequisitionID ? result.purchaseRequisitionID + 1 : 200001;
        }
    });

    this.before('CREATE', 'PurchaseOrder', async (req) => {
        if (!req.data.purchaseOrderID) {
            const { PurchaseOrder } = this.entities;
            const result = await SELECT.one.from(PurchaseOrder).columns('purchaseOrderID').orderBy({ purchaseOrderID: 'desc' });
            req.data.purchaseOrderID = result && result.purchaseOrderID ? result.purchaseOrderID + 1 : 300001;
        }
    });

    this.before('CREATE', 'GoodsReceipt', async (req) => {
        if (!req.data.goodsReceiptID) {
            const { GoodsReceipt } = this.entities;
            const result = await SELECT.one.from(GoodsReceipt).columns('goodsReceiptID').orderBy({ goodsReceiptID: 'desc' });
            req.data.goodsReceiptID = result && result.goodsReceiptID ? result.goodsReceiptID + 1 : 400001;
        }
    });

    this.before('CREATE', 'Invoice', async (req) => {
        if (!req.data.invoiceID) {
            const { Invoice } = this.entities;
            const result = await SELECT.one.from(Invoice).columns('invoiceID').orderBy({ invoiceID: 'desc' });
            req.data.invoiceID = result && result.invoiceID ? result.invoiceID + 1 : 500001;
        }
    });
    this.after('CREATE', 'PurchaseRequisition', async (data, req) => {
        try {
            // Because Fiori draft activations sometimes only pass the ID to the hook, ensure we have full data:
            const { PurchaseRequisition } = this.entities;
            const fullData = await SELECT.one.from(PurchaseRequisition).where({ ID: data.ID });

            console.log("=== WORKFLOW TRIGGER DEBUG ===");
            console.log("Full DB Data Read: ", JSON.stringify(fullData));
            if (!fullData) return; // safeguard

            const BPA_DESTINATION = 'bpa_destination';
            // In a real BTP deployment, this destination points to SAP Build Process Automation API
            const workflowService = await cds.connect.to(BPA_DESTINATION);

            const payload = {
                "definitionId": "us10.a777775ftrial.prapprovalworkflow.PR_Approval_Workflow",
                "context": {
                    // Exhaustive casing Variations for BPA Mapping
                    "purchaseRequisitionID": fullData.purchaseRequisitionID,
                    "purchase_requisition_id": fullData.purchaseRequisitionID,
                    "purchaserequisitionid": fullData.purchaseRequisitionID,
                    "id": fullData.purchaseRequisitionID,
                    "pr_id": fullData.purchaseRequisitionID,

                    "ShortText": fullData.ShortText || "New PR",
                    "shortText": fullData.ShortText || "New PR",
                    "short_text": fullData.ShortText || "New PR",
                    "description": fullData.ShortText || "New PR",
                    "Description": fullData.ShortText || "New PR",

                    "Quantity": Number(fullData.Quantity) || 1,
                    "quantity": Number(fullData.Quantity) || 1,

                    "ValuationPrice": Number(fullData.ValuationPrice) || 0,
                    "valuationPrice": Number(fullData.ValuationPrice) || 0,
                    "valuation_price": Number(fullData.ValuationPrice) || 0,
                    "price": Number(fullData.ValuationPrice) || 0,
                    "Price": Number(fullData.ValuationPrice) || 0,

                    "DesiredVendor": fullData.DesiredVendor || "Unknown",
                    "desiredVendor": fullData.DesiredVendor || "Unknown",
                    "desired_vendor": fullData.DesiredVendor || "Unknown",
                    "vendor": fullData.DesiredVendor || "Unknown",
                    "Vendor": fullData.DesiredVendor || "Unknown"
                }
            };
            console.log("TRIGGERING BPA WITH PAYLOAD: ", JSON.stringify(payload));
            console.log("SENDING PAYLOAD: ", JSON.stringify(payload));

            // Example endpoint for SAP BPA Workflow start
            await workflowService.send('POST', '/workflow/rest/v1/workflow-instances', payload);
            console.log(`Workflow triggered for PR: ${data.purchaseRequisitionID}`);
        } catch (error) {
            console.error("Workflow not triggered (Expected in local run without bpa_destination):", error.message);
        }
    });

    this.on('approve', async (req) => {
        // Robust ID extraction: Check for multiple naming possibilities from BPA
        const purchaseRequisitionID = req.data.purchaseRequisitionID || req.data.purchaserequisitionid || req.data.pr_id;
        
        console.log("=== BPA CALLBACK: APPROVE ACTION RECEIVED ===");
        console.log("RAW REQ DATA: ", JSON.stringify(req.data));
        console.log("Resolved PR ID:", purchaseRequisitionID);

        const { PurchaseRequisition, PurchaseOrder } = this.entities;

        // 1. Get PR Details
        const pr = await SELECT.one.from(PurchaseRequisition).where({ purchaseRequisitionID });
        console.log("DB Record Found:", JSON.stringify(pr));

        if (!pr) {
            console.error(`ERROR: PR ${purchaseRequisitionID} could not be found in DB.`);
            return req.error(404, `Purchase Requisition ${purchaseRequisitionID} not found`);
        }

        // 2. Update PR Status to APPROVED
        await UPDATE(PurchaseRequisition).set({ Status: 'APPROVED' }).where({ purchaseRequisitionID });

        // 3. Create PO
        const newPO = {
            PurchaseOrderType: 'NB',
            Supplier: pr.DesiredVendor || 'Unknown Vendor',
            SupplierNumber: '1000',
            OrderQuantity: pr.Quantity,
            NetPrice: pr.ValuationPrice,
            Currency: 'USD',
            PurchaseOrg: pr.PurchaseOrg,
            PurchaseGroup: pr.PurchaseGroup,
            Status: 'OPEN',
            refPurchaseRequisitionID: purchaseRequisitionID,
            CreatedBy: 'Workflow',
            ApprovedBy: 'Manager'
        };

        await INSERT.into(PurchaseOrder).entries(newPO);
        console.log("SUCCESS: Purchase Order created automatically.");
        return req.reply({ message: `PR ${purchaseRequisitionID} approved and PO created.` });
    });

    this.on('reject', async (req) => {
        const purchaseRequisitionID = req.data.purchaseRequisitionID || req.data.purchaserequisitionid || req.data.pr_id;
        console.log("=== BPA CALLBACK: REJECT ACTION RECEIVED ===");
        console.log("Resolved PR ID:", purchaseRequisitionID);

        const { PurchaseRequisition } = this.entities;

        const pr = await SELECT.one.from(PurchaseRequisition).where({ purchaseRequisitionID });
        if (!pr) {
            console.error(`ERROR: PR ${purchaseRequisitionID} not found for rejection.`);
            return req.error(404, `Purchase Requisition ${purchaseRequisitionID} not found`);
        }

        await UPDATE(PurchaseRequisition).set({ Status: 'REJECTED' }).where({ purchaseRequisitionID });
        return req.reply({ message: `PR ${purchaseRequisitionID} rejected.` });
    });
});
