using MyService as service from '../../srv/service';
annotate service.Contract with @(
    UI.FieldGroup #GeneratedGroup : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : companyCode,
            },
            {
                $Type : 'UI.DataField',
                Value : loanNumber,
            },
            {
                $Type : 'UI.DataField',
                Value : productType,
            },
            {
                $Type : 'UI.DataField',
                Value : loanType,
            },
            {
                $Type : 'UI.DataField',
                Value : loanPartner,
            },
            {
                $Type : 'UI.DataField',
                Label : 'applicationDate',
                Value : applicationDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'applicationCapital',
                Value : applicationCapital,
            },
            {
                $Type : 'UI.DataField',
                Label : 'approvalDate',
                Value : approvalDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'commitmentDate',
                Value : commitmentDate,
            },
            {
                $Type : 'UI.DataField',
                Label : 'loanPurpose',
                Value : loanPurpose,
            },
            {
                $Type : 'UI.DataField',
                Label : 'arBillingJob',
                Value : arBillingJob,
            },
            {
                $Type : 'UI.DataField',
                Label : 'country',
                Value : country,
            },
            {
                $Type : 'UI.DataField',
                Label : 'orgDistrict',
                Value : orgDistrict,
            },
            {
                $Type : 'UI.DataField',
                Label : 'agentDistrict',
                Value : agentDistrict,
            },
            {
                $Type : 'UI.DataField',
                Label : 'primaryIndustryCode',
                Value : primaryIndustryCode,
            },
            {
                $Type : 'UI.DataField',
                Label : 'legacyNumber',
                Value : legacyNumber,
            },
            {
                $Type : 'UI.DataField',
                Label : 'projectNumber',
                Value : projectNumber,
            },
            {
                $Type : 'UI.DataField',
                Label : 'commitCapital',
                Value : commitCapital,
            },
            {
                $Type : 'UI.DataField',
                Label : 'repaymentType',
                Value : repaymentType,
            },
            {
                $Type : 'UI.DataField',
                Label : 'fixedFrom',
                Value : fixedFrom,
            },
            {
                $Type : 'UI.DataField',
                Label : 'fixedUntil',
                Value : fixedUntil,
            },
            {
                $Type : 'UI.DataField',
                Label : 'include',
                Value : include,
            },
            {
                $Type : 'UI.DataField',
                Label : 'intCalMt',
                Value : intCalMt,
            },
            {
                $Type : 'UI.DataField',
                Label : 'postAdjustmentFlag',
                Value : postAdjustmentFlag,
            },
        ],
    },
    UI.Facets : [
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Basic data',
            ID : 'Basicdata',
            Facets : [
                {
                    $Type : 'UI.CollectionFacet',
                    Label : 'Basic Data',
                    ID : 'BasicData',
                    Facets : [
                        {
                            $Type : 'UI.ReferenceFacet',
                            Label : 'Application/Approval',
                            ID : 'ApplicationApproval',
                            Target : '@UI.FieldGroup#ApplicationApproval',
                        },
                    ],
                },
                {
                    $Type : 'UI.CollectionFacet',
                    Label : 'Analysis Data',
                    ID : 'AnalyssData',
                    Facets : [
                        {
                            $Type : 'UI.ReferenceFacet',
                            Label : 'Information',
                            ID : 'Information',
                            Target : '@UI.FieldGroup#Information',
                        },
                    ],
                },
                {
                    $Type : 'UI.CollectionFacet',
                    Label : 'Organization',
                    ID : 'Organization',
                    Facets : [
                        {
                            $Type : 'UI.ReferenceFacet',
                            Label : 'Agent Data',
                            ID : 'AgentData',
                            Target : '@UI.FieldGroup#AgentData',
                        },
                    ],
                },
                {
                    $Type : 'UI.CollectionFacet',
                    Label : 'Reference Data',
                    ID : 'ReferenceData',
                    Facets : [
                        {
                            $Type : 'UI.ReferenceFacet',
                            Label : 'Group Key',
                            ID : 'Group',
                            Target : '@UI.FieldGroup#Group',
                        },
                        {
                            $Type : 'UI.ReferenceFacet',
                            Label : 'Other References',
                            ID : 'OtherReferences',
                            Target : '@UI.FieldGroup#OtherReferences',
                        },
                    ],
                },
            ],
        },
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Conditons',
            ID : 'Conditons',
            Facets : [
                {
                    $Type : 'UI.CollectionFacet',
                    Label : 'Conditions',
                    ID : 'Conditions',
                    Facets : [
                        {
                            $Type : 'UI.ReferenceFacet',
                            Label : '      ',
                            ID : '_',
                            Target : '@UI.FieldGroup#_',
                        },
                    ],
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Term/Fixed Period',
                    ID : 'TermFixedPeriod',
                    Target : '@UI.FieldGroup#TermFixedPeriod',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Interest Calculation',
                    ID : 'InterestCalculation',
                    Target : '@UI.FieldGroup#InterestCalculation',
                },
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Condition Items',
                    ID : 'ConditionItems',
                    Target : 'contractToCondition/@UI.LineItem#ConditionItems',
                },
            ],
        },
        {
            $Type : 'UI.CollectionFacet',
            Label : 'Partners',
            ID : 'Partners',
            Facets : [
                {
                    $Type : 'UI.ReferenceFacet',
                    Label : 'Partners',
                    ID : 'Partners1',
                    Target : 'contractToPartner/@UI.LineItem#Partners',
                },
            ],
        },
    ],
    UI.LineItem : [
        {
            $Type : 'UI.DataField',
            Value : loanNumber,
        },
        {
            $Type : 'UI.DataField',
            Value : productType,
        },
        {
            $Type : 'UI.DataField',
            Value : loanType,
        },
        {
            $Type : 'UI.DataField',
            Value : loanPartner,
        },
    ],
    UI.HeaderInfo : {
        TypeName : '',
        TypeNamePlural : '',
    },
    UI.FieldGroup #ApplicationApproval : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : applicationDate,
                Label : 'Application Date',
            },
            {
                $Type : 'UI.DataField',
                Value : approvalDate,
                Label : 'Approval Date',
            },
            {
                $Type : 'UI.DataField',
                Value : applicationCapital,
                Label : 'Application Capital',
            },
            {
                $Type : 'UI.DataField',
                Value : commitmentDate,
                Label : 'Commitment Date',
            },
        ],
    },
    UI.FieldGroup #Information : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : loanPurpose,
                Label : 'Purpose of Loan',
            },
            {
                $Type : 'UI.DataField',
                Value : arBillingJob,
                Label : 'AR Billing Job',
            },
        ],
    },
    UI.FieldGroup #AgentData : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : country,
                Label : 'County',
            },
            {
                $Type : 'UI.DataField',
                Value : orgDistrict,
                Label : 'Organiz.District',
            },
            {
                $Type : 'UI.DataField',
                Value : agentDistrict,
                Label : 'Agent District',
            },
        ],
    },
    UI.FieldGroup #Group : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : primaryIndustryCode,
                Label : 'Primary Industry ',
            },
        ],
    },
    UI.FieldGroup #OtherReferences : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : legacyNumber,
                Label : 'Legacy Number',
            },
            {
                $Type : 'UI.DataField',
                Value : projectNumber,
                Label : 'Project Number',
            },
        ],
    },
    UI.FieldGroup #_ : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : commitCapital,
                Label : 'Commit Capital',
            },
        ],
    },
    UI.FieldGroup #TermFixedPeriod : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : fixedFrom,
                Label : 'Fixed From',
            },
            {
                $Type : 'UI.DataField',
                Value : fixedUntil,
                Label : 'Fixed Until',
            },
            {
                $Type : 'UI.DataField',
                Value : include,
                Label : 'Inclusive Indicator',
            },
        ],
    },
    UI.FieldGroup #InterestCalculation : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : intCalMt,
                Label : 'Int.Cal.Mt',
            },
        ],
    },
);

annotate service.ConditionItemsNew with @(
    UI.LineItem #ConditionItems : [
        {
            $Type : 'UI.DataField',
            Value : conditionTypeText,
            Label : 'Cond.Type Text',
        },
        {
            $Type : 'UI.DataField',
            Value : effectiveFrom,
            Label : 'Eff. From',
        },
        {
            $Type : 'UI.DataField',
            Value : percentage,
            Label : 'Percentage',
        },
        {
            $Type : 'UI.DataField',
            Value : conditionAmt,
            Label : 'Condition Amnt',
        },
        {
            $Type : 'UI.DataField',
            Value : paymentFromExactDay,
            Label : 'Payment From Exact Day',
        },
        {
            $Type : 'UI.DataField',
            Value : frequencyInMonths,
            Label : 'Frequency in Months',
        },
        {
            $Type : 'UI.DataField',
            Value : dueDate,
            Label : 'Due Date',
        },
        {
            $Type : 'UI.DataField',
            Value : calculationDate,
            Label : 'Calculation Date',
        },
    ]
);

annotate service.Partners with @(
    UI.LineItem #Partners : [
        {
            $Type : 'UI.DataField',
            Value : title,
            Label : 'Title',
        },
        {
            $Type : 'UI.DataField',
            Value : nameAddress,
            Label : 'Name/Address',
        },
        {
            $Type : 'UI.DataField',
            Value : startRel,
            Label : 'Strt rel.',
        },
        {
            $Type : 'UI.DataField',
            Value : endRel,
            Label : 'End relat.',
        },
        {
            $Type : 'UI.DataField',
            Value : addressType,
            Label : 'Address Type',
        },
        {
            $Type : 'UI.DataField',
            Value : partner,
            Label : 'Partner',
        },
    ],
    UI.HeaderInfo : {
        TypeName : '',
        TypeNamePlural : '',
    },
    UI.Facets : [
        {
            $Type : 'UI.ReferenceFacet',
            Label : 'Attributes for Selected Partner',
            ID : 'AttributesforSelectedPartner',
            Target : '@UI.FieldGroup#AttributesforSelectedPartner',
        },
    ],
    UI.FieldGroup #AttributesforSelectedPartner : {
        $Type : 'UI.FieldGroupType',
        Data : [
            {
                $Type : 'UI.DataField',
                Value : title,
                Label : 'Titile',
            },
            {
                $Type : 'UI.DataField',
                Value : nameAddress,
                Label : 'Name/Address',
            },
            {
                $Type : 'UI.DataField',
                Value : startRel,
                Label : 'Strt rel.',
            },
            {
                $Type : 'UI.DataField',
                Value : endRel,
                Label : 'End relat.',
            },
            {
                $Type : 'UI.DataField',
                Value : addressType,
                Label : 'Address Type',
            },
            {
                $Type : 'UI.DataField',
                Value : partner,
                Label : 'Partner',
            },
            {
                $Type : 'UI.DataField',
                Value : roleType,
                Label : 'Role Type',
            },
            {
                $Type : 'UI.DataField',
                Value : bankDetailsID,
                Label : 'Bank Details ID',
            },
            {
                $Type : 'UI.DataField',
                Value : dunningLetter,
                Label : 'Dunning Letter',
            },
            {
                $Type : 'UI.DataField',
                Value : customer,
                Label : 'Customer',
            },
            {
                $Type : 'UI.DataField',
                Value : dunnChargesPyr,
                Label : 'Dunn.Charges Pyr',
            },
            {
                $Type : 'UI.DataField',
                Value : paymentMethod,
                Label : 'Payment Method',
            },
        ],
    },
);

