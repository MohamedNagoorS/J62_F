using { asset_MasterSrv } from '../srv/service.cds';

annotate asset_MasterSrv.AssetMaster with @UI.HeaderInfo: { TypeName: 'Asset Master', TypeNamePlural: 'Asset Masters', Title: { Value: assetMasterID } };
annotate asset_MasterSrv.AssetMaster with {
  ID @UI.Hidden @Common.Text: { $value: assetMasterID, ![@UI.TextArrangement]: #TextOnly }
};
annotate asset_MasterSrv.AssetMaster with @UI.Identification: [{ Value: assetMasterID }];
annotate asset_MasterSrv.AssetMaster with {
  assetMasterID @title: 'ID';
  AssetClass @title: 'Asset Class';
  Description @title: 'Description';
  CompanyCode @title: 'Company Code';
  CostCenter @title: 'Cost Center';
  CapitalizedOn @title: 'Capitalized On';
};

annotate asset_MasterSrv.AssetMaster with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: assetMasterID },
 { $Type: 'UI.DataField', Value: AssetClass },
 { $Type: 'UI.DataField', Value: Description },
 { $Type: 'UI.DataField', Value: CompanyCode },
 { $Type: 'UI.DataField', Value: CostCenter },
 { $Type: 'UI.DataField', Value: CapitalizedOn },
 { $Type: 'UI.DataField', Value: refPurchaseRequisitionID }
];

annotate asset_MasterSrv.AssetMaster with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: assetMasterID },
 { $Type: 'UI.DataField', Value: AssetClass },
 { $Type: 'UI.DataField', Value: Description },
 { $Type: 'UI.DataField', Value: CompanyCode },
 { $Type: 'UI.DataField', Value: CostCenter },
 { $Type: 'UI.DataField', Value: CapitalizedOn },
 { $Type: 'UI.DataField', Value: refPurchaseRequisitionID }
  ]
};

annotate asset_MasterSrv.AssetMaster with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate asset_MasterSrv.AssetMaster with @UI.SelectionFields: [
  assetMasterID
];

annotate asset_MasterSrv.PurchaseRequisition with @UI.HeaderInfo: { TypeName: 'Purchase Requisition', TypeNamePlural: 'Purchase Requisitions', Title: { Value: purchaseRequisitionID } };
annotate asset_MasterSrv.PurchaseRequisition with {
  ID @UI.Hidden @Common.Text: { $value: purchaseRequisitionID, ![@UI.TextArrangement]: #TextOnly }
};
annotate asset_MasterSrv.PurchaseRequisition with @UI.Identification: [{ Value: purchaseRequisitionID }];
annotate asset_MasterSrv.PurchaseRequisition with {
  purchaseRequisitionID @title: 'ID';
  AccountAssignmentCategory @title: 'Account Assignment Category';
  ShortText @title: 'Short Text';
  Quantity @title: 'Quantity';
  UnitOfMeasure @title: 'Unit Of Measure';
  MaterialGroup @title: 'Material Group';
  Plant @title: 'Plant';
  PurchaseOrg @title: 'Purchase Organization';
  PurchaseGroup @title: 'Purchase Group';
  DesiredVendor @title: 'Desired Vendor';
  ValuationPrice @title: 'Valuation Price';
  refAssetMasterID @title: 'Asset Master ID';
  Status @title: 'Status';
};

annotate asset_MasterSrv.PurchaseRequisition with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: purchaseRequisitionID },
 { $Type: 'UI.DataField', Value: AccountAssignmentCategory },
 { $Type: 'UI.DataField', Value: ShortText },
 { $Type: 'UI.DataField', Value: Quantity },
 { $Type: 'UI.DataField', Value: UnitOfMeasure },
  { $Type: 'UI.DataField', Value: MaterialGroup },
  { $Type: 'UI.DataField', Value: Plant },
  { $Type: 'UI.DataField', Value: PurchaseOrg },
  { $Type: 'UI.DataField', Value: PurchaseGroup },
  { $Type: 'UI.DataField', Value: DesiredVendor },
  { $Type: 'UI.DataField', Value: ValuationPrice },
  { $Type: 'UI.DataField', Value: refAssetMasterID },
  { $Type: 'UI.DataField', Value: Status }
];

annotate asset_MasterSrv.PurchaseRequisition with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: purchaseRequisitionID },
 { $Type: 'UI.DataField', Value: AccountAssignmentCategory },
 { $Type: 'UI.DataField', Value: ShortText },
 { $Type: 'UI.DataField', Value: Quantity },
 { $Type: 'UI.DataField', Value: UnitOfMeasure },
  { $Type: 'UI.DataField', Value: MaterialGroup },
  { $Type: 'UI.DataField', Value: Plant },
  { $Type: 'UI.DataField', Value: PurchaseOrg },
  { $Type: 'UI.DataField', Value: PurchaseGroup },
  { $Type: 'UI.DataField', Value: DesiredVendor },
  { $Type: 'UI.DataField', Value: ValuationPrice },
  { $Type: 'UI.DataField', Value: refAssetMasterID },
  { $Type: 'UI.DataField', Value: Status }
  ]
};

annotate asset_MasterSrv.PurchaseRequisition with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate asset_MasterSrv.PurchaseRequisition with @UI.SelectionFields: [
  purchaseRequisitionID
];

annotate asset_MasterSrv.PurchaseOrder with @UI.HeaderInfo: { TypeName: 'Purchase Order', TypeNamePlural: 'Purchase Orders', Title: { Value: purchaseOrderID } };
annotate asset_MasterSrv.PurchaseOrder with {
  ID @UI.Hidden @Common.Text: { $value: purchaseOrderID, ![@UI.TextArrangement]: #TextOnly }
};
annotate asset_MasterSrv.PurchaseOrder with @UI.Identification: [{ Value: purchaseOrderID }];
annotate asset_MasterSrv.PurchaseOrder with {
  purchaseOrderID @title: 'ID';
  PurchaseOrderType @title: 'Purchase Order Type';
  Supplier @title: 'Supplier';
  OrderQuantity @title: 'Order Quantity';
  NetPrice @title: 'Net Price';
  refGoodsReceiptID @title: 'Goods Receipt ID'
};

annotate asset_MasterSrv.PurchaseOrder with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: purchaseOrderID },
 { $Type: 'UI.DataField', Value: PurchaseOrderType },
 { $Type: 'UI.DataField', Value: Supplier },
 { $Type: 'UI.DataField', Value: OrderQuantity },
 { $Type: 'UI.DataField', Value: NetPrice },
 { $Type: 'UI.DataField', Value: refGoodsReceiptID }
];

annotate asset_MasterSrv.PurchaseOrder with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: purchaseOrderID },
 { $Type: 'UI.DataField', Value: PurchaseOrderType },
 { $Type: 'UI.DataField', Value: Supplier },
 { $Type: 'UI.DataField', Value: OrderQuantity },
 { $Type: 'UI.DataField', Value: NetPrice },
 { $Type: 'UI.DataField', Value: refGoodsReceiptID }
  ]
};

annotate asset_MasterSrv.PurchaseOrder with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate asset_MasterSrv.PurchaseOrder with @UI.SelectionFields: [
  purchaseOrderID
];

annotate asset_MasterSrv.GoodsReceipt with @UI.HeaderInfo: { TypeName: 'Goods Receipt', TypeNamePlural: 'Goods Receipts', Title: { Value: goodsReceiptID } };
annotate asset_MasterSrv.GoodsReceipt with {
  ID @UI.Hidden @Common.Text: { $value: goodsReceiptID, ![@UI.TextArrangement]: #TextOnly }
};
annotate asset_MasterSrv.GoodsReceipt with @UI.Identification: [{ Value: goodsReceiptID }];
annotate asset_MasterSrv.GoodsReceipt with {
  goodsReceiptID @title: 'ID';
  MaterialDocument @title: 'Material Document';
  PostingDate @title: 'Posting Date';
  refInvoiceID @title: 'Invoice ID'
};

annotate asset_MasterSrv.GoodsReceipt with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: goodsReceiptID },
 { $Type: 'UI.DataField', Value: MaterialDocument },
 { $Type: 'UI.DataField', Value: PostingDate },
 { $Type: 'UI.DataField', Value: refInvoiceID }
];

annotate asset_MasterSrv.GoodsReceipt with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: goodsReceiptID },
 { $Type: 'UI.DataField', Value: MaterialDocument },
 { $Type: 'UI.DataField', Value: PostingDate },
 { $Type: 'UI.DataField', Value: refInvoiceID }
  ]
};

annotate asset_MasterSrv.GoodsReceipt with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate asset_MasterSrv.GoodsReceipt with @UI.SelectionFields: [
  goodsReceiptID
];

annotate asset_MasterSrv.Invoice with @UI.HeaderInfo: { TypeName: 'Invoice', TypeNamePlural: 'Invoices', Title: { Value: invoiceID } };
annotate asset_MasterSrv.Invoice with {
  ID @UI.Hidden @Common.Text: { $value: invoiceID, ![@UI.TextArrangement]: #TextOnly }
};
annotate asset_MasterSrv.Invoice with @UI.Identification: [{ Value: invoiceID }];
annotate asset_MasterSrv.Invoice with {
  invoiceID @title: 'ID';
  SupplierInvoiceNumber @title: 'Supplier Invoice Number';
  FiscalYear @title: 'Fiscal Year';
  GrossAmount @title: 'Gross Amount';
  TaxCode @title: 'Tax Code'
};

annotate asset_MasterSrv.Invoice with @UI.LineItem: [
 { $Type: 'UI.DataField', Value: invoiceID },
 { $Type: 'UI.DataField', Value: SupplierInvoiceNumber },
 { $Type: 'UI.DataField', Value: FiscalYear },
 { $Type: 'UI.DataField', Value: GrossAmount },
 { $Type: 'UI.DataField', Value: TaxCode }
];

annotate asset_MasterSrv.Invoice with @UI.FieldGroup #Main: {
  $Type: 'UI.FieldGroupType', Data: [
 { $Type: 'UI.DataField', Value: invoiceID },
 { $Type: 'UI.DataField', Value: SupplierInvoiceNumber },
 { $Type: 'UI.DataField', Value: FiscalYear },
 { $Type: 'UI.DataField', Value: GrossAmount },
 { $Type: 'UI.DataField', Value: TaxCode }
  ]
};

annotate asset_MasterSrv.Invoice with @UI.Facets: [
  { $Type: 'UI.ReferenceFacet', ID: 'Main', Label: 'General Information', Target: '@UI.FieldGroup#Main' }
];

annotate asset_MasterSrv.Invoice with @UI.SelectionFields: [
  invoiceID
];

