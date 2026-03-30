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
            if (!fullData) {
                console.error("CRITICAL: No database record found for PR ID:", data.ID);
                return;
            }

            const BPA_DESTINATION = 'bpa_destination';
            // In a real BTP deployment, this destination points to SAP Build Process Automation API
            const workflowService = await cds.connect.to(BPA_DESTINATION);

            const payload = {
                "definitionId": "us10.a777775ftrial.prapprovalworkflow.PR_Approval_Workflow",
                "context": {
                    // Exhaustive casing Variations for BPA Mapping
                    "purchaseRequisitionID": fullData.purchaseRequisitionID || 0,
                    "purchase_requisition_id": fullData.purchaseRequisitionID || 0,
                    "pr_id": fullData.purchaseRequisitionID || 0,

                    "ShortText": fullData.ShortText || "PR Description Missing",
                    "shortText": fullData.ShortText || "PR Description Missing",
                    "description": fullData.ShortText || "PR Description Missing",

                    "Quantity": Number(fullData.Quantity) || 1,
                    "quantity": Number(fullData.Quantity) || 1,

                    "ValuationPrice": Number(fullData.ValuationPrice) || 0.0,
                    "valuationPrice": Number(fullData.ValuationPrice) || 0.0,
                    "price": Number(fullData.ValuationPrice) || 0.0,

                    "DesiredVendor": fullData.DesiredVendor || "No Vendor Specified",
                    "desiredVendor": fullData.DesiredVendor || "No Vendor Specified",
                    "vendor": fullData.DesiredVendor || "No Vendor Specified"
                }
            };
            console.log("FINAL PAYLOAD TO BPA: ", JSON.stringify(payload));

            // Example endpoint for SAP BPA Workflow start
            await workflowService.send('POST', '/workflow/rest/v1/workflow-instances', payload);
            console.log(`Workflow triggered for PR: ${data.purchaseRequisitionID}`);
        } catch (error) {
            console.error("Workflow not triggered (Expected in local run without bpa_destination):", error.message);
        }
    });

    this.on('approvePR', async (req) => {


        console.log("=== BPA CALLBACK: APPROVE ACTION RECEIVED ===");

        // THIS IS THE MAGIC LINE: It prints the exact, raw JSON sent by SAP Build
        console.log("RAW PAYLOAD FROM BPA: ", JSON.stringify(req.data));

        const purchaseRequisitionID = req.data.purchaseRequisitionID || req.data.purchaserequisitionid || req.data.pr_id;
        console.log("Resolved PR ID:", purchaseRequisitionID);

        // Stop the code safely if the ID is missing, rather than crashing the DB
        if (!purchaseRequisitionID) {
            console.error("CRITICAL: BPA did not send a valid ID!");
            return req.error(400, "Missing PR ID from Workflow.");
        }
        const { PurchaseRequisition, PurchaseOrder } = this.entities;

        // 1. Get PR Details
        const pr = await SELECT.one.from(PurchaseRequisition).where({ purchaseRequisitionID });
        if (!pr) return req.error(404, `Purchase Requisition ${purchaseRequisitionID} not found`);

        // 2. Update PR Status to APPROVED
        await UPDATE(PurchaseRequisition).set({ Status: 'APPROVED' }).where({ purchaseRequisitionID });

        // 3. Manually calculate the next PO ID (Because INSERT.into bypasses before hooks)
        let nextPOId = 300001;
        const result = await SELECT.one.from(PurchaseOrder)
            .columns('purchaseOrderID')
            .where('purchaseOrderID IS NOT NULL')
            .orderBy({ purchaseOrderID: 'desc' });

        if (result && result.purchaseOrderID) {
            nextPOId = parseInt(result.purchaseOrderID, 10) + 1;
        }

        // 4. Generate a Delivery Date (7 days from today)
        const today = new Date();
        today.setDate(today.getDate() + 7);
        const deliveryDateStr = today.toISOString().split('T')[0]; // Formats to YYYY-MM-DD

        // 5. Create PO
        const newPO = {
            ID: cds.utils.uuid(),               // Required: Hidden UUID for Fiori Drafts
            IsActiveEntity: true,               // Required: Tells Fiori this is not a draft
            purchaseOrderID: nextPOId,          // Required: The calculated running Integer
            DeliveryDate: deliveryDateStr,
            PurchaseOrderType: 'NB',
            Supplier: pr.DesiredVendor || 'Unknown Vendor',
            SupplierNumber: '1000',
            OrderQuantity: pr.Quantity,
            NetPrice: pr.ValuationPrice,
            Currency: 'USD',
            PurchaseOrg: pr.PurchaseOrg,
            PurchaseGroup: pr.PurchaseGroup,
            Status: 'OPEN',
            refPurchaseRequisitionID: parseInt(purchaseRequisitionID, 10),
            CreatedBy: 'Workflow',
            ApprovedBy: 'Manager'
        };

        console.log("=== EXECUTING DB INSERT FOR PO ===");
        console.log("Payload:", JSON.stringify(newPO));

        await INSERT.into(PurchaseOrder).entries(newPO);
        console.log(`SUCCESS: PO ${nextPOId} created automatically.`);
        return req.reply({ message: `PR ${purchaseRequisitionID} approved and PO created.` });
    });

    this.on('rejectPR', async (req) => {
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