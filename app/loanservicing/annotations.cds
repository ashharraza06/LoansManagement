using LoanServicing as service from '../../srv/service';
annotate service.postingInvoices with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Label : 'contractNo',
                Value : contractNoLow,
            },
            {
                $Type : 'UI.DataField',
                Label : 'productType',
                Value : productTypeLow,
            },
            {
                $Type : 'UI.DataField',
                Label : 'loanType',
                Value : loanTypeLow,
            },
            {
                $Type : 'UI.DataField',
                Label : 'flowType',
                Value : flowTypeLow,
            },
            {
                $Type : 'UI.DataField',
                Label : 'paymentMethod',
                Value : paymentMethodLow,
            },
            {
                $Type : 'UI.DataField',
                Label : 'includingPmntDate',
                Value : includingPmntDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'postingDate',
                Value : postingDateLow,
            },
            {
                $Type : 'UI.DataField',
                Label : 'documentDate',
                Value : documentDateLow,
            },
            {
                $Type : 'UI.DataField',
                Label : 'documentText',
                Value : documentText,
            },
            {
                $Type : 'UI.DataField',
                Label : 'testRun',
                Value : testRun,
            },
            {
                $Type : 'UI.DataField',
                Label : 'log',
                Value : log,
            },
            {
                $Type : 'UI.DataField',
                Label : 'outputInOneLog',
                Value : outputInOneLog,
            },
            {
                $Type : 'UI.DataField',
                Label : 'postingInspiteOfErrors',
                Value : postingInspiteOfErrors,
            },
            {
                $Type : 'UI.DataField',
                Label : 'outputOfUnpostedContracts',
                Value : outputOfUnpostedContracts,
            },
            {
                $Type : 'UI.DataField',
                Label : 'bankRoutingNumber',
                Value : bankRoutingNumber,
            },
            {
                $Type : 'UI.DataField',
                Label : 'bankAccount',
                Value : bankAccount,
            },
            {
                $Type : 'UI.DataField',
                Label : 'group',
                Value : group,
            },
            {
                $Type : 'UI.DataField',
                Label : 'userName',
                Value : userName,
            },
            {
                $Type : 'UI.DataField',
                Label : 'entryDate',
                Value : entryDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'Transaction',
                Value : Transaction,
            },
            {
                $Type : 'UI.DataField',
                Label : 'postingDate2',
                Value : postingDate2,
            },
            {
                $Type : 'UI.DataField',
                Label : 'valueDate',
                Value : valueDate,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Post Invoices',
            ID : 'PostInvoices',
            Target : '@UI.FieldGroup#PostInvoices',
        },
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Processing Incoming Payments',
            ID : 'ProcessingIncomingPayments1',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Processing Incoming Payments',
                    ID : 'ProcessingIncomingPayments',
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
                    Label : '         ',
                    ID : 'table',
                    Target : 'postingInvoicesToContractIncomingPayments/@UI.LineItem#table',
                },
            ],
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Label : 'Contract Number',
            Value : contractNo,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Agency',
            Value : productType,
        },
        {
            $Type : 'UI.DataField',
            Label : 'Loan Program',
            Value : loanType,
        },
        {
            $Type : 'UI.DataField',
            Label : 'flowType',
            Value : flowType,
            @UI.Hidden,
        },
        {
            $Type : 'UI.DataField',
            Label : 'paymentMethod',
            Value : paymentMethod,
            @UI.Hidden,
        },
    ],
    UI.FieldGroup #PostInvoices : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : contractNo,
            },
            {
                $Type : 'UI.DataField',
                Value : paymentMethod,
            },
            {
                $Type : 'UI.DataField',
                Value : documentText,
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
                Value : productType,
                Label : 'Agency1',
                @UI.Hidden,
            },
            {
                $Type : 'UI.DataField',
                Value : pledgedStatus,
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
                Value : postingInspiteOfErrors,
            },
            {
                $Type : 'UI.DataField',
                Value : loanType,
                Label : 'Loan Program1',
                @UI.Hidden,
            },
            {
                $Type : 'UI.DataField',
                Value : postingInvoicesToloanType.loanType,
                Label : 'Loan Program',
            },
            {
                $Type : 'UI.DataField',
                Value : postingDate,
            },
            {
                $Type : 'UI.DataField',
                Value : log,
            },
            {
                $Type : 'UI.DataField',
                Value : outputOfUnpostedContracts,
            },
            {
                $Type : 'UI.DataField',
                Value : flowType,
                Label : 'Flow Type1',
                @UI.Hidden,
            },
            {
                $Type : 'UI.DataField',
                Value : postingInvoicesToflowType.flowType,
                Label : 'Flow Type',
            },
            {
                $Type : 'UI.DataField',
                Value : documentDate,
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
        TypeName : '',
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
    ],
    UI.LineItem #table : [
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
    ],
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
            Label : 'value',
        },
        Common.ValueListWithFixedValues : true,
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
            Label : 'val',
        },
        Common.ValueListWithFixedValues : true,
)};

