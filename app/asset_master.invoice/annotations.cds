using asset_MasterSrv as service from '../../srv/service';
using from '../annotations';

annotate service.Invoice with @(
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : invoiceID,
        },
        {
            $Type : 'UI.DataField',
            Value : SupplierInvoiceNumber,
        },
        {
            $Type : 'UI.DataField',
            Value : FiscalYear,
        },
        {
            $Type : 'UI.DataField',
            Value : GrossAmount,
        },
        {
            $Type : 'UI.DataField',
            Value : TaxCode,
        },
        {
            $Type : 'UI.DataField',
            Value : Currency,
            Label : 'Currency',
        },
        {
            $Type : 'UI.DataField',
            Value : InvoiceDate,
            Label : 'InvoiceDate',
        },
        {
            $Type : 'UI.DataField',
            Value : PostingDate,
            Label : 'PostingDate',
        },
        {
            $Type : 'UI.DataField',
            Value : Reference,
            Label : 'Reference',
        },
        {
            $Type : 'UI.DataField',
            Value : refGoodsReceiptID,
            Label : 'refGoodsReceiptID',
        },
        {
            $Type : 'UI.DataField',
            Value : TransactionType,
            Label : 'TransactionType',
        },
    ],
    UI.FieldGroup #Main : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : invoiceID,
            },
            {
                $Type : 'UI.DataField',
                Value : SupplierInvoiceNumber,
            },
            {
                $Type : 'UI.DataField',
                Value : FiscalYear,
            },
            {
                $Type : 'UI.DataField',
                Value : GrossAmount,
            },
            {
                $Type : 'UI.DataField',
                Value : TaxCode,
            },
            {
                $Type : 'UI.DataField',
                Value : Currency,
                Label : 'Currency',
            },
            {
                $Type : 'UI.DataField',
                Value : InvoiceDate,
                Label : 'InvoiceDate',
            },
            {
                $Type : 'UI.DataField',
                Value : PostedBy,
                Label : 'PostedBy',
            },
            {
                $Type : 'UI.DataField',
                Value : PostingDate,
                Label : 'PostingDate',
            },
            {
                $Type : 'UI.DataField',
                Value : refGoodsReceiptID,
                Label : 'refGoodsReceiptID',
            },
            {
                $Type : 'UI.DataField',
                Value : TransactionType,
                Label : 'TransactionType',
            },
        ],
    },
);

