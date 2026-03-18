namespace Asset_Accounting;
using { cuid } from '@sap/cds/common';

@assert.unique: { assetMasterID: [assetMasterID] }
entity AssetMaster : cuid {
  assetMasterID: Integer @mandatory;
  AssetClass: String(10);
  Description: String(255);
  CompanyCode: String(4);
  CostCenter: String(10);
  CapitalizedOn: Date;
}

@assert.unique: { purchaseRequisitionID: [purchaseRequisitionID] }
entity PurchaseRequisition : cuid {
  purchaseRequisitionID: Integer @mandatory;
  AccountAssignmentCategory: String(1); 
  ShortText: String(255);
  Quantity: Integer;
  UnitOfMeasure: String(10);
  MaterialGroup: String(10);
  Plant: String(4);
  ValuationPrice: Decimal(10,2);
  refAssetMasterID: Integer; 
}

@assert.unique: { purchaseOrderID: [purchaseOrderID] }
entity PurchaseOrder : cuid {
  purchaseOrderID: Integer @mandatory;
  PurchaseOrderType: String(20);
  Supplier: String(255);
  OrderQuantity: Integer;
  NetPrice: Decimal(10,2);
  refPurchaseRequisitionID: Integer; 
}

@assert.unique: { goodsReceiptID: [goodsReceiptID] }
entity GoodsReceipt : cuid {
  goodsReceiptID: Integer @mandatory;
  MaterialDocument: String(255);
  PostingDate: Date;
  refPurchaseOrderID: Integer; 
}

@assert.unique: { invoiceID: [invoiceID] }
entity Invoice : cuid {
  invoiceID: Integer @mandatory;
  SupplierInvoiceNumber: String(255);
  FiscalYear: String(4);
  GrossAmount: Decimal(10,2);
  TaxCode: String(2);
  refGoodsReceiptID: Integer; 
}