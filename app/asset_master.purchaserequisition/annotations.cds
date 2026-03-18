using asset_MasterSrv as service from '../../srv/service';
using from '../annotations';

annotate service.PurchaseRequisition with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : purchaseRequisitionID,
            Label : '{i18n>Id}',
        },
        {
            $Type : 'UI.DataField',
            Value : AccountAssignmentCategory,
            Label : '{i18n>AccountAssignmentCategory}',
        },
        {
            $Type : 'UI.DataField',
            Value : ShortText,
            Label : '{i18n>ShortText}',
        },
        {
            $Type : 'UI.DataField',
            Value : Quantity,
            Label : '{i18n>Quantity}',
        },
        {
            $Type : 'UI.DataField',
            Value : UnitOfMeasure,
            Label : '{i18n>UnitOfMeasure}',
        },
        {
            $Type : 'UI.DataField',
            Value : MaterialGroup,
            Label : '{i18n>MaterialGroup}',
        },
        {
            $Type : 'UI.DataField',
            Value : Plant,
            Label : '{i18n>Plant}',
        },
        {
            $Type : 'UI.DataField',
            Value : ValuationPrice,
            Label : '{i18n>ValuationPrice}',
        },
        {
            $Type : 'UI.DataField',
            Value : refAssetMasterID,
            Label : '{i18n>Refassetmasterid}',
        },
    ],
    UI.FieldGroup #Main : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : purchaseRequisitionID,
                Label : '{i18n>Id}',
            },
            {
                $Type : 'UI.DataField',
                Value : AccountAssignmentCategory,
                Label : '{i18n>AccountAssignmentCategory}',
            },
            {
                $Type : 'UI.DataField',
                Value : ShortText,
                Label : '{i18n>ShortText}',
            },
            {
                $Type : 'UI.DataField',
                Value : Quantity,
                Label : '{i18n>Quantity}',
            },
            {
                $Type : 'UI.DataField',
                Value : UnitOfMeasure,
                Label : '{i18n>UnitOfMeasure}',
            },
            {
                $Type : 'UI.DataField',
                Value : MaterialGroup,
                Label : '{i18n>MaterialGroup}',
            },
            {
                $Type : 'UI.DataField',
                Value : Plant,
                Label : '{i18n>Plant}',
            },
            {
                $Type : 'UI.DataField',
                Value : ValuationPrice,
                Label : '{i18n>ValuationPrice}',
            },
            {
                $Type : 'UI.DataField',
                Value : refAssetMasterID,
                Label : '{i18n>Refassetmasterid}',
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            ID : 'Main',
            Label : '{i18n>GeneralInformation}',
            Target : '@UI.FieldGroup#Main',
        },
    ],
    UI.HeaderInfo : {
        TypeName : '{i18n>PurchaseRequisition}',
        TypeNamePlural : '{i18n>PurchaseRequisitions}',
        Title : {
            $Type : 'UI.DataField',
            Value : purchaseRequisitionID,
        },
    },
);

annotate service.PurchaseRequisition with {
    purchaseRequisitionID @Common.Label : '{i18n>Id}'
};

