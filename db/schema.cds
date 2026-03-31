namespace db;


using {
    cuid,
    managed
} from '@sap/cds/common';

/* =========================
   ROOT LOAN ENTITY
========================= */
entity Contract : managed {
        /* ---------- Step 1 : Initial Screen ---------- */
    key ID                     : UUID;
        companyCode            : String       @Common.Label: 'Company Code';
    key loanNumber             : String       @mandatory  @Common.Label: 'Loan Number';
    key productType            : String       @mandatory  @Common.Label: 'Agency';
    key loanType               : String       @mandatory  @Common.Label: 'Loan Program';
    key bpNumber               : String       @mandatory  @Common.Label: 'BP Number';
        // key loanPartnerName        : String  @mandatory  @Common.Label: 'Loan Partner Name';


        status                 : String;
        disbursementStatus     : String;

        /* ---------- Number Composition ---------- */
        // loanIndicator       : String(1);
        // numberRange         : String(10);
        // divider             : String(1);


        /* ---------- Basic Data ---------- */
        // //classification
        // loanTypeBD          : String(3);
        // Application/approval
        applicationDate        : Date         @Common.Label: 'Application Date';
        applicationCapital     : Decimal      @Common.Label: 'Application Capital';
        approvalDate           : Date         @Common.Label: 'Approval Date';
        commitmentDate         : Date         @Common.Label: 'Commitment Date';

        /* ---------- Analysis Data ---------- */
        // Information
        loanPurpose            : String       @Common.Label: 'Funding Category';
        // arBillingJob           : String;
        /* ---------- Amortization Status ---------- */
        amortizationStatus     : String       @Common.Label: 'Amortization Status';

        /* ---------- Organization ---------- */
        // agentdata
        country                : String       @Common.Label: 'County';
        orgDistrict            : String       @Common.Label: 'Organiz District';
        agentDistrict          : String       @Common.Label: 'Agent District';

        /* ---------- Reference Data ---------- */
        // groupkey
        primaryIndustryCode    : String       @Common.Label: 'Primary Industry';
        // other references
        legacyNumber           : String       @Common.Label: 'Legacy Number';
        projectNumber          : String       @Common.Label: 'Project Number';


        //conditions
        commitCapital          : Decimal      @mandatory  @Common.Label: 'Current Commitment Capital';
        outstandLoanBalance    : Decimal      @Common.Label: 'Outstanding Loan Balance';
        repaymentType          : String;

        //term/fixed Period
        fixedFrom              : Date         @mandatory  @Common.Label: 'Amortization Start';
        fixedUntil             : Date         @mandatory  @Common.Label: 'Amortization End';
        include                : Boolean;

        //PENNVEST
        designation            : String       @Common.Label: Designation;
        pledgedStatus          : String       @Common.Label: 'Pledged Status';
        datePaidOff            : Date         @Common.Label: 'Date Paid Off';

        //Comments Tab From Data

        //Offer
        offerOn                : Date         @Common.Label: 'Approved On';
        offerUntil             : Date         @Common.Label: 'Offer Until';
        reservedOn             : Date;
        reservedUntil          : Date;

        //Acceptance
        acceptance             : Boolean;
        acceptedOn             : Date         @Common.Label: 'Accepted On';
        acceptancedType        : Integer;
        reservation            : Integer;

        //Contract/Eff.int

        contract               : String;
        contractOn             : Date         @Common.Label: 'Loan Close Date';
        contractCompleteDate   : Date         @Common.Label: 'Contract Completed Date';
        amtzDate               : Date         @mandatory  @Common.Label: 'Loan Begin Date';
        maturityDate           : Date         @mandatory  @Common.Label: 'Loan Maturity Date';


        //Interest Calculation
        intCalMt               : String       @mandatory;
        postAdjustmentFlag     : Boolean;

        //notice

        intresetRateResetType  : Integer      @Common.Label: 'Interest Rate Reset Type';
        intresetRateResetDate  : Date         @Common.Label: 'Interest Rate Reset Date';
        //capital amount
        contractCapital        : Decimal;
        disbursementOblig      : Decimal;
        valueDatedCapital      : Decimal;
        effectCapital          : Decimal;

        //Incoming payment
        paymentMethod          : String       @Common.Label: 'Incoming Payment Method';
        payoffLock             : Boolean      @Common.Label: 'Payoff Lock';
        arBillingJob           : String       @Common.Label: 'AR Billing Job';
        relevantIndicator      : Boolean      @Common.Label: '1098 Relevant Indicator';
        //Exclude from dunning
        dunningIndicator       : Boolean      @Common.Label: 'Exclude from Dunning Indicator';
        reason                 : String       @Common.Label: 'Reason';
        dateofBankruptcy       : Date         @COmmon.Label: 'Date of Bankruptcy';
        comments               : String(1000) @Common.Label: 'Comments';

        /* ---------- Associations ---------- */

        contractToCondition    : Composition of many ConditionItemsNew
                                     on contractToCondition.contractId = ID;
        contractToPartner      : Composition of many Partners
                                     on contractToPartner.id = ID;
        contracttoAttachments  : Composition of many Attachments
                                     on contracttoAttachments.contraid = ID;
        contractToEarmark      : Composition of many Earmark
                                     on contractToEarmark.id = ID;
        contractToDisbursement : Composition of many Disbursement
                                     on contractToDisbursement.id = ID;
}


//condition items according to cash flow
entity ConditionItemsNew : managed {
    key conditionId         : UUID;
        contractId          : UUID;
        conditionTypeText   : String(20);
        effectiveFrom       : Date;
        percentage          : String(4);
        conditionAmt        : Decimal;
        paymentFromExactDay : String;
        frequencyInMonths   : String(4);
        dueDate             : Date;
        calculationDate     : Date;
        sequence            : Integer;
        endCondition        : String;
        businessPartner     : String;
        calculationBase     : String;
        intCalMt            : String;
        conditionToContract : Association to Contract;


}

entity ConditionTypeTextSearchHelpNew {
    key ID    : UUID;
        value : String;

}

entity Partners : managed {
    key partnerId         : UUID;
        id                : UUID;
        title             : String;
        nameAddress       : String;

        startRel          : Date;
        endRel            : Date;

        addressType       : String;
        partner           : String @Common.Label: 'Partner No.';
        bpRole            : String(6);

        roleType          : String;
        customer          : String @Common.Label: 'Customer No.';
        bankDetailsID     : String(4);

        dunningLetter     : String;
        dunnChargesPyr    : Boolean;

        partnerToContract : Association to Contract;
}

entity Attachments : cuid, managed {
    contraid              : UUID;

    @Core.MediaType  : MediaType
    Content               : LargeBinary;

    @Core.IsMediaType: true
    MediaType             : String;
    FileName              : String;
    Size                  : Integer;
    Url                   : String;

    AttachmentsToContract : Association to Contract;
}

entity EntityAuditLogs {
    key id            : UUID;
        DateTime      : String;
        User          : String;
        OperationType : String;
        Entity        : String;
        Changes       : String;
        toChanges     : Composition of many Changes
                            on toChanges.toEntityAuditLogs = $self;

}

entity Changes {
    key Field             : String;
    key id                : UUID;
        OldValue          : String;
        NewValue          : String;
        toEntityAuditLogs : Association to one EntityAuditLogs
                                on toEntityAuditLogs.id = id;
}

entity PaymentMethodSearchHelp {
    key code : String;
        name : String;

}

entity ARBillingJobSearchHelp {
    key jobCode  : String;
        longName : String;
}

entity AmortizationStatusSearchHelp {
    key amzt      : String;
        shortName : String;
}

entity Earmark {
    key earmarkId         : UUID;
        id                : UUID;
        documentNumber    : Integer @Common.Label: 'Document Line Number';
        loanCategory      : String  @Common.Label: 'Loan Category';
        flowType          : String  @Common.Label: 'Flow Type';
        orginalAount      : Decimal @Common.Label: 'Original Amount';
        text              : String  @Common.Label: 'Text';
        fund              : Decimal @Common.Label: 'Fund';
        budgetPd          : String  @Common.Label: 'Budget Pd';
        glAccount         : String  @Common.Label: 'GL Account';
        commitmetItem     : String  @Common.Label: 'Commitment Item';
        fundCenter        : String  @Common.Label: 'Fund Center';
        functionalArea    : String  @Common.Label: 'Functional Area';
        bussinessArea     : String  @Common.Label: 'bussinessArea';
        costCenter        : String  @Common.Label: 'Cost Center';
        order             : String  @Common.Label: 'Order';
        wbsElement        : String  @Common.Label: 'WBS Element';
        isCompleted       : Boolean @Common.Label: 'Completion Indicator';
        earmarkToContract : Association to Contract;
}

entity Disbursement {
    key disbursementId         : UUID;
        id                     : UUID;
        text                   : String  @Common.Label: 'Line Item';
        disburseAmount         : Decimal @Common.Label: 'New Disburse Amount';
        flowType               : String  @Common.Label: 'Flow Type';
        grossAmount            : String  @Common.Label: 'Gross Amount'  default '0000'       @readonly;
        disbursementOblig      : String  @Common.Label: 'Disbursement Oblig.'  default '  '  @readonly;
        paymentDate            : Date    @Common.Label: 'Payment Date';
        effectiveDate          : Date    @Common.Label: 'Effective Date';
        bp                     : String  @Common.Label: 'Business Partner';
        paymentMethod          : String  @Common.Label: 'Payment Method';
        bankDetails            : String  @Common.Label: 'Bank Details';
        houseBank              : String  @Common.Label: 'House Bank';
        disbursementToContract : Association to Contract;
}

// entity WorkflowHistory : managed {
//         contractID                     : UUID;
//     key level                          : Int16;
//     key EmployeeID                     : String;
//         EmployeeName                   : String;
//         Status                         : String;
//         ApprovedBy                     : String;
//         DaysTaken                      : String;
//         BeginDateAndTime               : String;
//         EndDateAndTime                 : String;
//         //workflow History//


//         // Title                  : String;
//         // NotificationStatus     : String;
//         // Remarks                : String;

//         NfaWorkflowHistoryToNfaDetails : Association to one NfaDetails
//                                              on NfaWorkflowHistoryToNfaDetails.NfaNumber = NfaNumber;
// }

entity loanCategorySearchHelp {

    key category : String;
        flowtype : String;

}

entity paymentFromExactDaySearchHelp {
    key ID          : UUID;
        value       : String;
        description : String;
}

entity intCalMtSearchHelp {
    key ID    : UUID;
        value : String;
}

entity reasonSearchHelp {
    key ID    : UUID;
        value : String;
}

entity postingInvoices {
    key id                                        : UUID;
        contractNo                                : String  @Common.Label: 'Contract Number';
        productType                               : String  @Common.Label: 'Agency';
        loanType                                  : String  @Common.Label: 'Loan Program';
        flowType                                  : String  @Common.Label: 'Flow Type';
        pledgedStatus                             : String  @Common.Label: 'Pledged Status';
        paymentMethod                             : String  @Common.Label: 'Payment Method';
        includingPmntDate                         : Date    @Common.Label: 'Up To And Including pmnt Date';
        postingDate                               : Date    @Common.Label: 'Posting Date';
        documentDate                              : Date    @Common.Label: 'Document Date';
        documentText                              : String  @Common.Label: 'Document Text';
        testRun                                   : Boolean @Common.Label: 'Test Run';
        log                                       : Boolean @Common.Label: 'Log';
        outputInOneLog                            : Boolean @Common.Label: 'Output in One Log(Background Only)';
        postingInspiteOfErrors                    : Boolean @Common.Label: 'Posting In Spite of Errors in Individual Contracts';
        outputOfUnpostedContracts                 : Boolean @Common.Label: 'Output of Unposted Contracts';
        // IncomingPayments
        bankRoutingNumber                         : String  @Common.Label: 'Bank Routing Number';
        bankAccount                               : String  @Common.Label: 'Bank Account';
        group                                     : String  @Common.Label: 'Group';
        userName                                  : String  @Common.Label: 'User Name';
        entryDate                                 : Date    @Common.Label: 'Entry Date';
        Transaction                               : String  @Common.Label: 'Transaction';
        postingDate2                              : Date    @Common.Label: 'Posting Date';
        valueDate                                 : Date    @Common.Label: 'Value Date';
        postingInvoicesToContractIncomingPayments : Composition of many contractIncomingPayments
                                                        on postingInvoicesToContractIncomingPayments.postingId = id;
        postingInvoicesToProductType              : Composition of many productType
                                                        on postingInvoicesToProductType.prodid = id;
        postingInvoicesToloanType                 : Composition of many loanType
                                                        on postingInvoicesToloanType.contid = id;
        postingInvoicesToflowType                 : Composition of many flowType
                                                        on postingInvoicesToflowType.contid = id;
        postingInvoicesTocontractNo               : Composition of many contractNo
                                                        on postingInvoicesTocontractNo.contid = id;
        postingInvoicesTopaymentMethod1           : Composition of many paymentMethod1
                                                        on postingInvoicesTopaymentMethod1.contid = id;
        postingInvoicesTopledgedStatus            : Composition of many pledgedStatus
                                                        on postingInvoicesTopledgedStatus.contid = id;
// postingInvoicesTotransaction            : Composition of many transaction
//                                                 on postingInvoicesTotransaction.contid = id;

}
// entity postingInvoices {

//     key id                                        : UUID;

//         /* Contract Selection */

//         contractNoLow                             : String  @Common.Label: 'Contract Number From';
//         contractNoHigh                            : String  @Common.Label: 'Contract Number To';

//         productTypeLow                            : String  @Common.Label: 'Agency From';
//         productTypeHigh                           : String  @Common.Label: 'Agency To';

//         loanTypeLow                               : String  @Common.Label: 'Loan Program From';
//         loanTypeHigh                              : String  @Common.Label: 'Loan Program To';

//         flowTypeLow                               : String  @Common.Label: 'Flow Type From';
//         flowTypeHigh                              : String  @Common.Label: 'Flow Type To';

//         paymentMethodLow                          : String  @Common.Label: 'Payment Method From';
//         paymentMethodHigh                         : String  @Common.Label: 'Payment Method To';

//         includingPmntDate                         : Date    @Common.Label: 'Up To And Including pmnt Date';

//         postingDateLow                            : Date    @Common.Label: 'Posting Date From';
//         postingDateHigh                           : Date    @Common.Label: 'Posting Date To';

//         documentDateLow                           : Date    @Common.Label: 'Document Date From';
//         documentDateHigh                          : Date    @Common.Label: 'Document Date To';

//         documentText                              : String  @Common.Label: 'Document Text';

//         /* Flags */

//         testRun                                   : Boolean @Common.Label: 'Test Run';
//         log                                       : Boolean @Common.Label: 'Log';
//         outputInOneLog                            : Boolean @Common.Label: 'Output in One Log (Background Only)';
//         postingInspiteOfErrors                    : Boolean @Common.Label: 'Posting In Spite of Errors in Individual Contracts';
//         outputOfUnpostedContracts                 : Boolean @Common.Label: 'Output of Unposted Contracts';

//         /* Incoming Payments */

//         bankRoutingNumber                         : String  @Common.Label: 'Bank Routing Number';
//         bankAccount                               : String  @Common.Label: 'Bank Account';
//         group                                     : String  @Common.Label: 'Group';
//         userName                                  : String  @Common.Label: 'User Name';
//         entryDate                                 : Date    @Common.Label: 'Entry Date';
//         Transaction                               : String  @Common.Label: 'Transaction';

//         postingDate2                              : Date    @Common.Label: 'Posting Date';
//         valueDate                                 : Date    @Common.Label: 'Value Date';

//         postingInvoicesToContractIncomingPayments : Composition of many contractIncomingPayments
//                                                         on postingInvoicesToContractIncomingPayments.postingId = id;
// }


entity contractIncomingPayments {
    key incomingId                                : UUID;
        postingId                                 : UUID;
        contractNumber                            : String  @Common.Label: 'Contract Number';
        segment                                   : String  @Common.Label: 'Segment';
        checkNo                                   : String  @Common.Label: 'Check No.';
        amount                                    : Decimal @Common.Label: 'Amount';
        contractIncomingPaymentsToPostingInvoices : Association to Contract;
}

entity productType : cuid {
    prodid                      : UUID;
    productType                 : String;
    productTypeToPostingInvoice : Association to Contract;
}

entity productTypeSearchHelp {
    key ID    : UUID;
        value : String @Common.Label: 'Agency';
}

entity loanType : cuid {
    contid                   : UUID;
    loanType                 : String;
    loanTypeToPostingInvoice : Association to Contract;
}

entity loanTypeSearchHelp {
    key ID    : UUID;
        value : String @Common.Label: 'Loan Program';
}

entity flowType : cuid {
    contid                   : UUID;
    flowType                 : String;
    flowTypeToPostingInvoice : Association to Contract;
}

entity flowTypeSearchHelp {
    key ID    : UUID;
        value : String @Common.Label: 'Flow Type';
}

entity contractNo : cuid {
    contid                     : UUID;
    contractNo                 : String;
    contractNoToPostingInvoice : Association to Contract;
}

entity contractNoSearchHelp : cuid {

    value : String @Common.Label: 'Contract Number';
}

entity paymentMethod1 : cuid {
    contid                        : UUID;
    paymentMethod                 : String;
    paymentMethodToPostingInvoice : Association to Contract;
}

entity paymentMethodSearchHelp1 {
    key code : String @Common.Label: 'Payment Method';
        name : String @Common.Label: 'Description';
}

entity pledgedStatus : cuid {
    contid                        : UUID;
    pledgedStatus                 : String @Common.Label : 'Pledged Status';
    pledgedStatusToPostingInvoice : Association to Contract;
}

entity pledgedStatusSearchHelp {
    key code        : String @Common.Label: 'Pledged Status';
        description : String @Common.Label: 'Description';
}

// entity transaction : cuid {
//     contid                      : UUID;
//     transaction                 : String;
//     transactionToPostingInvoice : Association to Contract;
// }

entity transactionSearchHelp {
    key code        : String @Common.Label: 'Transaction';
        description : String @Common.Label: 'Description';
}
