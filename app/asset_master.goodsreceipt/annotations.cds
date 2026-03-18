using asset_MasterSrv as service from '../../srv/service';
using from '../annotations';

annotate service.GoodsReceipt with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : goodsReceiptID,
        },
        {
            $Type : 'UI.DataField',
            Value : MaterialDocument,
        },
        {
            $Type : 'UI.DataField',
            Value : PostingDate,
        },
        {
            $Type : 'UI.DataField',
            Value : refPurchaseOrderID,
            Label : 'refPurchaseOrderID',
        },
    ],
    UI.FieldGroup #Main : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : goodsReceiptID,
            },
            {
                $Type : 'UI.DataField',
                Value : MaterialDocument,
            },
            {
                $Type : 'UI.DataField',
                Value : PostingDate,
            },
            {
                $Type : 'UI.DataField',
                Value : refPurchaseOrderID,
                Label : 'refPurchaseOrderID',
            },
        ],
    },
);

