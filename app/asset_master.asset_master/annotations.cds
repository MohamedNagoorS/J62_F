using asset_MasterSrv as service from '../../srv/service';
using from '../annotations';

annotate service.AssetMaster with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : assetMasterID,
        },
        {
            $Type : 'UI.DataField',
            Value : AssetClass,
        },
        {
            $Type : 'UI.DataField',
            Value : Description,
        },
        {
            $Type : 'UI.DataField',
            Value : CompanyCode,
        },
        {
            $Type : 'UI.DataField',
            Value : CostCenter,
        },
        {
            $Type : 'UI.DataField',
            Value : CapitalizedOn,
        },
    ],
    UI.FieldGroup #Main : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : assetMasterID,
            },
            {
                $Type : 'UI.DataField',
                Value : AssetClass,
            },
            {
                $Type : 'UI.DataField',
                Value : Description,
            },
            {
                $Type : 'UI.DataField',
                Value : CompanyCode,
            },
            {
                $Type : 'UI.DataField',
                Value : CostCenter,
            },
            {
                $Type : 'UI.DataField',
                Value : CapitalizedOn,
            },
        ],
    },
);

