using LoanServicing1 as service from '../../srv/service';
using from '../../db/schema';

annotate service.postingInvoices with @(
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Post Invoice',
            ID : 'PostInvoice',
            Target : '@UI.FieldGroup#PostInvoice',
        },
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Processing Incoming Payments',
            ID : 'ProcessingIncomingPayments',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Processing Incoming Payments',
                    ID : 'ProcessingIncomingPayments1',
                    Target : '@UI.FieldGroup#ProcessingIncomingPayments',
                },
                {
                    $Type : 'UI.CollectionFacet',
                    Label : 'Control',
                    ID : 'Control1',
                    Facets : [
                        {
                            $Type : 'UI.ReferenceFacet',
                            Label : 'Control',
                            ID : 'Control',
                            Target : '@UI.FieldGroup#Control',
                        },
                    ],
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : '  ',
                    ID : '_',
                    Target : 'postingInvoicesToContractIncomingPayments/@UI.LineItem#_',
                },
            ],
        },
    ],
    UI.FieldGroup #PostInvoice : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : postingInvoicesTocontractNo.contractNo,
                Label : 'Contract Number',
            },
            {
                $Type : 'UI.DataField',
                Value : contractNo,
                @UI.Hidden,
            },
            {
                $Type : 'UI.DataField',
                Value : paymentMethod,
                @UI.Hidden,
            },
            {
                $Type : 'UI.DataField',
                Value : postingInvoicesTopaymentMethod1.paymentMethod,
                Label : 'Payment Method',
            },
            {
                $Type : 'UI.DataField',
                Value : documentDate,
            },
            {
                $Type : 'UI.DataField',
                Value : outputInOneLog,
            },
            {
                $Type : 'UI.DataField',
                Value : postingInvoicesToProductType.productType,
                Label : 'Agency',
            },
            {
                $Type : 'UI.DataField',
                Value : pledgedStatus,
                @UI.Hidden,
            },
            {
                $Type : 'UI.DataField',
                Value : postingInvoicesTopledgedStatus.pledgedStatus,
                Label : 'Pledged Status',
            },
            {
                $Type : 'UI.DataField',
                Value : documentText,
            },
            {
                $Type : 'UI.DataField',
                Value : postingInspiteOfErrors,
            },
            {
                $Type : 'UI.DataField',
                Value : postingInvoicesToloanType.loanType,
                Label : 'Loan Program',
            },
            {
                $Type : 'UI.DataField',
                Value : includingPmntDate,
            },
            {
                $Type : 'UI.DataField',
                Value : testRun,
            },
            {
                $Type : 'UI.DataField',
                Value : outputOfUnpostedContracts,
            },
            {
                $Type : 'UI.DataField',
                Value : postingInvoicesToflowType.flowType,
                Label : 'Flow Type',
            },
            {
                $Type : 'UI.DataField',
                Value : postingDate,
            },
            {
                $Type : 'UI.DataField',
                Value : log,
            },
        ],
    },
    UI.FieldGroup #ProcessingIncomingPayments : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : bankRoutingNumber,
            },
            {
                $Type : 'UI.DataField',
                Value : bankAccount,
            },
            {
                $Type : 'UI.DataField',
                Value : group,
            },
            {
                $Type : 'UI.DataField',
                Value : userName,
            },
            {
                $Type : 'UI.DataField',
                Value : entryDate,
            },
        ],
    },
    UI.FieldGroup #Control : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : Transaction,
            },
            {
                $Type : 'UI.DataField',
                Value : postingDate2,
            },
            {
                $Type : 'UI.DataField',
                Value : valueDate,
            },
        ],
    },
    UI.HeaderInfo : {
        TypeName : 'Loan Servicing',
        TypeNamePlural : '',
    },
);

annotate service.contractIncomingPayments with @(
    UI.LineItem #_ : [
        {
            $Type : 'UI.DataField',
            Value : contractNumber,
        },
        {
            $Type : 'UI.DataField',
            Value : segment,
        },
        {
            $Type : 'UI.DataField',
            Value : checkNo,
        },
        {
            $Type : 'UI.DataField',
            Value : amount,
        },
    ]
);

annotate service.productType with {
    productType @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'productTypeSearchHelp',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : productType,
                    ValueListProperty : 'value',
                },
            ],
            Label : 'val',
        },
        Common.ValueListWithFixedValues : false,
)};

annotate service.loanType with {
    loanType @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'loanTypeSearchHelp',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : loanType,
                    ValueListProperty : 'value',
                },
            ],
            Label : 'loanval',
        },
        Common.ValueListWithFixedValues : false,
)};

annotate service.flowType with {
    flowType @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'flowTypeSearchHelp',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : flowType,
                    ValueListProperty : 'value',
                },
            ],
            Label : 'valflow',
        },
        Common.ValueListWithFixedValues : false,
)};

annotate service.contractNo with {
    contractNo @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'contractNoSearchHelp',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : contractNo,
                    ValueListProperty : 'value',
                },
            ],
            Label : 'val',
        },
        Common.ValueListWithFixedValues : false,
)};

annotate service.paymentMethod1 with {
    paymentMethod @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'paymentMethodSearchHelp1',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : paymentMethod,
                    ValueListProperty : 'code',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'name',
                },
            ],
            Label : 'val',
        },
        Common.ValueListWithFixedValues : false,
)};

annotate service.transaction with {
    transaction @(
        UI.MultiLineText : false,
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'transactionSearchHelp',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : transaction,
                    ValueListProperty : 'code',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description',
                },
            ],
            Label : 'transval',
        },
        Common.ValueListWithFixedValues : false,
    )
};

annotate service.pledgedStatus with {
    pledgedStatus @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'pledgedStatusSearchHelp',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : pledgedStatus,
                    ValueListProperty : 'code',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description',
                },
            ],
            Label : 'pledval',
        },
        Common.ValueListWithFixedValues : false,
)};

annotate service.postingInvoices with {
    Transaction @(
        Common.ValueList : {
            $Type : 'Common.ValueListType',
            CollectionPath : 'transactionSearchHelp',
            Parameters : [
                {
                    $Type : 'Common.ValueListParameterInOut',
                    LocalDataProperty : Transaction,
                    ValueListProperty : 'code',
                },
                {
                    $Type : 'Common.ValueListParameterDisplayOnly',
                    ValueListProperty : 'description',
                },
            ],
            Label : 'transval',
        },
        Common.ValueListWithFixedValues : false,
)};

