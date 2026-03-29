using asset_MasterSrv as service from '../../srv/service';
using from '../annotations';

annotate service.PurchaseRequisition with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : purchaseRequisitionID,
        },
        {
            $Type : 'UI.DataField',
            Value : AccountAssignmentCategory,
        },
        {
            $Type : 'UI.DataField',
            Value : ShortText,
        },
        {
            $Type : 'UI.DataField',
            Value : Quantity,
        },
        {
            $Type : 'UI.DataField',
            Value : UnitOfMeasure,
        },
        {
            $Type : 'UI.DataField',
            Value : MaterialGroup,
        },
        {
            $Type : 'UI.DataField',
            Value : Plant,
        },
        {
            $Type : 'UI.DataField',
            Value : ValuationPrice,
        },
        {
            $Type : 'UI.DataField',
            Value : DesiredVendor,
            Label : 'DesiredVendor',
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
            Value : refAssetMasterID,
            Label : 'refAssetMasterID',
        },
        {
            $Type : 'UI.DataField',
            Value : Status,
            Label : 'Status',
        },
    ],
    UI.FieldGroup #Main : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : AccountAssignmentCategory,
            },
            {
                $Type : 'UI.DataField',
                Value : ShortText,
            },
            {
                $Type : 'UI.DataField',
                Value : Quantity,
            },
            {
                $Type : 'UI.DataField',
                Value : UnitOfMeasure,
            },
            {
                $Type : 'UI.DataField',
                Value : MaterialGroup,
            },
            {
                $Type : 'UI.DataField',
                Value : Plant,
            },
            {
                $Type : 'UI.DataField',
                Value : ValuationPrice,
            },
            {
                $Type : 'UI.DataField',
                Value : DesiredVendor,
                Label : 'DesiredVendor',
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
                Value : refAssetMasterID,
                Label : 'refAssetMasterID',
            },
            {
                $Type : 'UI.DataField',
                Value : Status,
                Label : 'Status',
            },
        ],
    },
);

