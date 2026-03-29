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
            Value : Currency,
            Label : 'Currency',
        },
        {
            $Type : 'UI.DataField',
            Value : DeliveryDate,
            Label : 'DeliveryDate',
        },
        {
            $Type : 'UI.DataField',
            Value : PurchaseGroup,
            Label : 'PurchaseGroup',
        },
        {
            $Type : 'UI.DataField',
            Value : PurchaseOrg,
            Label : 'PurchaseOrg',
        },
        {
            $Type : 'UI.DataField',
            Value : refPurchaseRequisitionID,
            Label : 'refPurchaseRequisitionID',
        },
        {
            $Type : 'UI.DataField',
            Value : Status,
            Label : 'Status',
        },
        {
            $Type : 'UI.DataField',
            Value : SupplierNumber,
            Label : 'SupplierNumber',
        },
    ],
    UI.FieldGroup #Main : {
        $Type : 'UI.FieldGroupType',
        Data : [
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
                Value : ApprovedBy,
                Label : 'ApprovedBy',
            },
            {
                $Type : 'UI.DataField',
                Value : Currency,
                Label : 'Currency',
            },
            {
                $Type : 'UI.DataField',
                Value : DeliveryDate,
                Label : 'DeliveryDate',
            },
            {
                $Type : 'UI.DataField',
                Value : PurchaseGroup,
                Label : 'PurchaseGroup',
            },
            {
                $Type : 'UI.DataField',
                Value : PurchaseOrg,
                Label : 'PurchaseOrg',
            },
            {
                $Type : 'UI.DataField',
                Value : refPurchaseRequisitionID,
                Label : 'refPurchaseRequisitionID',
            },
            {
                $Type : 'UI.DataField',
                Value : Status,
                Label : 'Status',
            },
            {
                $Type : 'UI.DataField',
                Value : SupplierNumber,
                Label : 'SupplierNumber',
            },
        ],
    },
);

