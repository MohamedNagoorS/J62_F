using { Asset_Accounting as my } from '../db/schema.cds';

@path : 'asset_accounting'
service asset_MasterSrv
{
    action approvePR(purchaseRequisitionID: Integer);
    action rejectPR(purchaseRequisitionID: Integer);

    annotate AssetMaster
    {
        AssetClass
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'AssetClassValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : AssetClass
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
        CompanyCode
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'CompanyCodeValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : CompanyCode
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
        CostCenter
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'CostCenterValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : CostCenter
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
        DepreciationKey
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'DepreciationKeyValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : DepreciationKey
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
    }

    annotate GoodsReceipt
    {
        refPurchaseOrderID
            @Common.ValueList : 
            {
                CollectionPath : 'PurchaseOrder',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'purchaseOrderID',
                        LocalDataProperty : refPurchaseOrderID
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'Supplier'
                    }
                ]
            };
    }

    annotate Invoice
    {
        TaxCode
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'TaxCodeValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : TaxCode
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
        refGoodsReceiptID
            @Common.ValueList : 
            {
                CollectionPath : 'GoodsReceipt',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'goodsReceiptID',
                        LocalDataProperty : refGoodsReceiptID
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'MaterialDocument'
                    }
                ]
            };
        TransactionType
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'InvoiceTransactionValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : TransactionType
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
        Currency
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'CurrencyValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : Currency
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
    }

    annotate PurchaseOrder
    {
        PurchaseOrderType
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'POTypeValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : PurchaseOrderType
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
        Status
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'POStatusValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : Status
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
        refPurchaseRequisitionID
            @Common.ValueList : 
            {
                CollectionPath : 'PurchaseRequisition',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'purchaseRequisitionID',
                        LocalDataProperty : refPurchaseRequisitionID
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'ShortText'
                    }
                ]
            };
        PurchaseGroup
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'PurchaseGroupValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : PurchaseGroup
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
        PurchaseOrg
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'PurchaseOrgValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : PurchaseOrg
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
        Currency
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'CurrencyValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : Currency
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
    }

    annotate PurchaseRequisition
    {
        UnitOfMeasure
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'UOMValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : UnitOfMeasure
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
        MaterialGroup
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'MaterialGroupValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : MaterialGroup
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
        Plant
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'PlantValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : Plant
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
        Status
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'PRStatusValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : Status
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
        refAssetMasterID
            @Common.ValueList : 
            {
                CollectionPath : 'AssetMaster',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'assetMasterID',
                        LocalDataProperty : refAssetMasterID
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'Description'
                    }
                ]
            };
        PurchaseGroup
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'PurchaseGroupValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : PurchaseGroup
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
        PurchaseOrg
            @Common.ValueListWithFixedValues
            @Common.ValueList : 
            {
                CollectionPath : 'PurchaseOrgValues',
                Parameters :
                [
                    {
                        $Type : 'Common.ValueListParameterInOut',
                        ValueListProperty : 'code',
                        LocalDataProperty : PurchaseOrg
                    },
                    {
                        $Type : 'Common.ValueListParameterDisplayOnly',
                        ValueListProperty : 'label'
                    }
                ]
            };
    }

    @odata.draft.enabled
    entity AssetMaster as
        projection on my.AssetMaster;

    @odata.draft.enabled
    entity PurchaseRequisition as
        projection on my.PurchaseRequisition;

    @odata.draft.enabled
    entity PurchaseOrder as
        projection on my.PurchaseOrder;

    @odata.draft.enabled
    entity GoodsReceipt as
        projection on my.GoodsReceipt;

    @odata.draft.enabled
    entity Invoice as
        projection on my.Invoice;

    @readonly
    entity AssetClassValues as
        projection on my.AssetClassValues;

    @readonly
    entity CompanyCodeValues as
        projection on my.CompanyCodeValues;

    @readonly
    entity CostCenterValues as
        projection on my.CostCenterValues;

    @readonly
    entity PlantValues as
        projection on my.PlantValues;

    @readonly
    entity UOMValues as
        projection on my.UOMValues;

    @readonly
    entity MaterialGroupValues as
        projection on my.MaterialGroupValues;

    @readonly
    entity PRStatusValues as
        projection on my.PRStatusValues;

    @readonly
    entity POTypeValues as
        projection on my.POTypeValues;

    @readonly
    entity POStatusValues as
        projection on my.POStatusValues;

    @readonly
    entity TaxCodeValues as
        projection on my.TaxCodeValues;

    @readonly
    entity DepreciationKeyValues as
        projection on my.DepreciationKeyValues;

    @readonly
    entity PurchaseGroupValues as
        projection on my.PurchaseGroupValues;

    @readonly
    entity PurchaseOrgValues as
        projection on my.PurchaseOrgValues;

    @readonly
    entity CurrencyValues as
        projection on my.CurrencyValues;

    @readonly
    entity InvoiceTransactionValues as
        projection on my.InvoiceTransactionValues;
}
