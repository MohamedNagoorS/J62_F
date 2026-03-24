namespace Asset_Accounting;
using { cuid } from '@sap/cds/common';

entity AssetClassValues {
  key code  : String(10);
      label : String(50);
}

entity CompanyCodeValues {
  key code  : String(4);
      label : String(50);
}

entity CostCenterValues {
  key code  : String(10);
      label : String(50);
}

entity PlantValues {
  key code  : String(4);
      label : String(50);
}

entity UOMValues {
  key code  : String(10);
      label : String(50);
}

entity MaterialGroupValues {
  key code  : String(10);
      label : String(50);
}

entity PurchaseGroupValues {
  key code  : String(3);
      label : String(50);
}

entity PurchaseOrgValues {
  key code  : String(4);
      label : String(50);
}

entity DepreciationKeyValues {
  key code  : String(10);
      label : String(50);
}

entity PRStatusValues {
  key code  : String(20);
      label : String(50);
}

entity POTypeValues {
  key code  : String(20);
      label : String(50);
}

entity POStatusValues {
  key code  : String(20);
      label : String(50);
}

entity TaxCodeValues {
  key code  : String(2);
      label : String(50);
}

entity CurrencyValues {
  key code  : String(5);
      label : String(50);
}

entity InvoiceTransactionValues {
  key code  : String(20);
      label : String(50);
}
@assert.unique: { assetMasterID: [assetMasterID] }
entity AssetMaster : cuid {
  assetMasterID   : Integer      @readonly;
  AssetClass      : String(10);
  AssetSubNumber  : String(4);
  Description     : String(255)  @mandatory;
  CompanyCode     : String(4);
  CostCenter      : String(10);
  CapitalizedOn   : Date;
  UsefulLife      : Integer;
  DepreciationKey : String(10);
  CreatedBy       : String(50);
}
@assert.unique: { purchaseRequisitionID: [purchaseRequisitionID] }
entity PurchaseRequisition : cuid {
  purchaseRequisitionID     : Integer       @readonly;
  ShortText                 : String(255)   @mandatory;
  AccountAssignmentCategory : String(1);
  Quantity                  : Integer;
  UnitOfMeasure             : String(10);
  MaterialGroup             : String(10);
  Plant                     : String(4);
  PurchaseGroup             : String(3);
  PurchaseOrg               : String(4);
  DesiredVendor             : String(20);
  ValuationPrice            : Decimal(10,2);
  Status                    : String(20);
  refAssetMasterID          : Integer;
  CreatedBy                 : String(50);
}
@assert.unique: { purchaseOrderID: [purchaseOrderID] }
entity PurchaseOrder : cuid {
  purchaseOrderID          : Integer       @readonly;
  PurchaseOrderType        : String(20);
  Supplier                 : String(255)   @mandatory;
  SupplierNumber           : String(20);
  OrderQuantity            : Integer;
  NetPrice                 : Decimal(10,2);
  Currency                 : String(5);
  DeliveryDate             : Date;
  PurchaseOrg              : String(4);
  PurchaseGroup            : String(3);
  Status                   : String(20);
  refPurchaseRequisitionID : Integer;
  CreatedBy                : String(50);
  ApprovedBy               : String(50);
}
@assert.unique: { invoiceID: [invoiceID] }
entity Invoice : cuid {
  invoiceID             : Integer       @readonly;
  TransactionType       : String(20);
  SupplierInvoiceNumber : String(255)   @mandatory;
  InvoiceDate           : Date;
  PostingDate           : Date;
  FiscalYear            : String(4);
  GrossAmount           : Decimal(10,2);
  Currency              : String(5);
  TaxCode               : String(2);
  Reference             : String(50);
  refGoodsReceiptID     : Integer;
  PostedBy              : String(50);
}
@assert.unique: { goodsReceiptID: [goodsReceiptID] }
entity GoodsReceipt : cuid {
  goodsReceiptID     : Integer       @readonly;
  MaterialDocument   : String(255);
  PostingDate        : Date          @mandatory;
  DocumentDate       : Date;
  DeliveryNoteNumber : String(50);
  Quantity           : Integer;
  StorageLocation    : String(10);
  refPurchaseOrderID : Integer;      
  ReceivedBy         : String(50);  
}