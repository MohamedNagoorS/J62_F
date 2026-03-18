using { Asset_Accounting as my } from '../db/schema.cds';

@path : 'asset_accounting'
service asset_MasterSrv {
    @odata.draft.enabled
    entity AssetMaster as projection on my.AssetMaster;

    @odata.draft.enabled
    entity PurchaseRequisition as projection on my.PurchaseRequisition;

    @odata.draft.enabled
    entity PurchaseOrder as projection on my.PurchaseOrder;

    @odata.draft.enabled
    entity GoodsReceipt as projection on my.GoodsReceipt;

    @odata.draft.enabled
    entity Invoice as projection on my.Invoice;


    annotate PurchaseRequisition with {
        refAssetMasterID @Common.ValueList : {
            CollectionPath : 'AssetMaster',
            Parameters     : [
                { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : refAssetMasterID, ValueListProperty : 'assetMasterID' },
                { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'Description' }
            ]
        }
    };

    annotate PurchaseOrder with {
        refPurchaseRequisitionID @Common.ValueList : {
            CollectionPath : 'PurchaseRequisition',
            Parameters     : [
                { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : refPurchaseRequisitionID, ValueListProperty : 'purchaseRequisitionID' },
                { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'ShortText' }
            ]
        }
    };

    annotate GoodsReceipt with {
        refPurchaseOrderID @Common.ValueList : {
            CollectionPath : 'PurchaseOrder',
            Parameters     : [
                { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : refPurchaseOrderID, ValueListProperty : 'purchaseOrderID' },
                { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'Supplier' }
            ]
        }
    };

    annotate Invoice with {
        refGoodsReceiptID @Common.ValueList : {
            CollectionPath : 'GoodsReceipt',
            Parameters     : [
                { $Type : 'Common.ValueListParameterInOut', LocalDataProperty : refGoodsReceiptID, ValueListProperty : 'goodsReceiptID' },
                { $Type : 'Common.ValueListParameterDisplayOnly', ValueListProperty : 'MaterialDocument' }
            ]
        }
    };
}