const cds = require('@sap/cds');

module.exports = cds.service.impl(async function() {
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
});
