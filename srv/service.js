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
            const BPA_DESTINATION = 'us10.a777775ftrial.prapprovalworkflow.PR_Approval_Workflow';
            // In a real BTP deployment, this destination points to SAP Build Process Automation API
            const workflowService = await cds.connect.to(BPA_DESTINATION);

            const payload = {
                "definitionId": "us10.a777775ftrial.prapprovalworkflow.PR_Approval_Workflow",
                "context": {
                    "purchaseRequisitionID": data.purchaseRequisitionID,
                    "ShortText": data.ShortText,
                    "Quantity": data.Quantity,
                    "ValuationPrice": data.ValuationPrice,
                    "DesiredVendor": data.DesiredVendor
                }
            };

            // Example endpoint for SAP BPA Workflow start
            await workflowService.send('POST', '/workflow/rest/v1/workflow-instances', payload);
            console.log(`Workflow triggered for PR: ${data.purchaseRequisitionID}`);
        } catch (error) {
            console.error("Workflow not triggered (Expected in local run without bpa_destination):", error.message);
        }
    });

    this.on('approve', async (req) => {
        const { purchaseRequisitionID } = req.data;
        const { PurchaseRequisition, PurchaseOrder } = this.entities;

        // 1. Get PR Details
        const pr = await SELECT.one.from(PurchaseRequisition).where({ purchaseRequisitionID });
        if (!pr) return req.error(404, `Purchase Requisition ${purchaseRequisitionID} not found`);

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
        return req.reply({ message: `PR ${purchaseRequisitionID} approved and PO created.` });
    });

    this.on('reject', async (req) => {
        const { purchaseRequisitionID } = req.data;
        const { PurchaseRequisition } = this.entities;

        const pr = await SELECT.one.from(PurchaseRequisition).where({ purchaseRequisitionID });
        if (!pr) return req.error(404, `Purchase Requisition ${purchaseRequisitionID} not found`);

        await UPDATE(PurchaseRequisition).set({ Status: 'REJECTED' }).where({ purchaseRequisitionID });
        return req.reply({ message: `PR ${purchaseRequisitionID} rejected.` });
    });
});
