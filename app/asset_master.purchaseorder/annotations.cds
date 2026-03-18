using asset_MasterSrv as service from '../../srv/service';
using from '../annotations';

annotate service.PurchaseOrder with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : purchaseOrderID,
        },
        {
            $Type : 'UI.DataField',
            Value : PurchaseOrderType,
        },
        {
            $Type : 'UI.DataField',
            Value : Supplier,
        },
        {
            $Type : 'UI.DataField',
            Value : OrderQuantity,
        },
        {
            $Type : 'UI.DataField',
            Value : NetPrice,
        },
        {
            $Type : 'UI.DataField',
            Value : refPurchaseRequisitionID,
            Label : 'refPurchaseRequisitionID',
        },
    ]
);

