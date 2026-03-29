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
            Value : DeliveryNoteNumber,
            Label : 'DeliveryNoteNumber',
        },
        {
            $Type : 'UI.DataField',
            Value : DocumentDate,
            Label : 'DocumentDate',
        },
        {
            $Type : 'UI.DataField',
            Value : Quantity,
            Label : 'Quantity',
        },
        {
            $Type : 'UI.DataField',
            Value : ReceivedBy,
            Label : 'ReceivedBy',
        },
        {
            $Type : 'UI.DataField',
            Value : refPurchaseOrderID,
            Label : 'refPurchaseOrderID',
        },
        {
            $Type : 'UI.DataField',
            Value : StorageLocation,
            Label : 'StorageLocation',
        },
    ],
    UI.FieldGroup #Main : {
        $Type : 'UI.FieldGroupType',
        Data : [
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
                Value : DeliveryNoteNumber,
                Label : 'DeliveryNoteNumber',
            },
            {
                $Type : 'UI.DataField',
                Value : DocumentDate,
                Label : 'DocumentDate',
            },
            {
                $Type : 'UI.DataField',
                Value : Quantity,
                Label : 'Quantity',
            },
            {
                $Type : 'UI.DataField',
                Value : ReceivedBy,
                Label : 'ReceivedBy',
            },
            {
                $Type : 'UI.DataField',
                Value : refPurchaseOrderID,
                Label : 'refPurchaseOrderID',
            },
            {
                $Type : 'UI.DataField',
                Value : StorageLocation,
                Label : 'StorageLocation',
            },
        ],
    },
);

