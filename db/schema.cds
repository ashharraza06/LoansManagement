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
        companyCode            : String  @Common.Label: 'Company Code';
    key loanNumber             : String  @mandatory  @Common.Label: 'Loan Number';
    key productType            : String  @mandatory  @Common.Label: 'Agency';
    key loanType               : String  @mandatory  @Common.Label: 'Loan Type';
    key bpNumber               : String  @mandatory  @Common.Label: 'BP Number';
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
        applicationDate        : Date;
        applicationCapital     : Decimal(15, 2);
        approvalDate           : Date;
        commitmentDate         : Date;

        /* ---------- Analysis Data ---------- */
        // Information
        loanPurpose            : String;
        // arBillingJob           : String;
        amortizationStatus     : String  @Common.Label: 'Amortization Status';

        /* ---------- Organization ---------- */
        // agentdata
        country                : String;
        orgDistrict            : String;
        agentDistrict          : String;

        /* ---------- Reference Data ---------- */
        // groupkey
        primaryIndustryCode    : String;
        // other references
        legacyNumber           : String;
        projectNumber          : String;


        //conditions
        commitCapital          : String  @mandatory;
        repaymentType          : String;

        //term/fixed Period
        fixedFrom              : Date    @mandatory;
        fixedUntil             : Date    @mandatory;
        include                : Boolean;

        //PENNVEST
        designation            : String;
        pledgedStatus          : String;
        datePaidOff            : Date;

        //Comments Tab From Data

        //Offer
        offerOn                : Date;
        offerUntil             : Date;
        reservedOn             : Date;
        reservedUntil          : Date;

        //Acceptance
        acceptance             : Boolean;
        acceptedOn             : Date;
        acceptancedType        : Integer;
        reservation            : Integer;

        //Contract/Eff.int

        contract               : String;
        contractOn             : Date;
        amtzDate               : Date;
        maturityDate           : Date;


        //Interest Calculation
        intCalMt               : String  @mandatory;
        postAdjustmentFlag     : Boolean;

        //notice

        intresetRateResetType  : Integer;
        intresetRateResetDate  : Date;
        //capital amount
        contractCapital        : Decimal;
        disbursementOblig      : Decimal;
        valueDatedCapital      : Decimal;
        effectCapital          : Decimal;

        //Incoming payment
        paymentMethod          : String  @Common.Label: 'Incoming Payment Method';
        payoffLock             : Boolean @Common.Label: 'Payoff Lock';
        arBillingJob           : String  @Common.Label: 'AR Billing Job';
        dunningIndicator       : Boolean @Common.Label: 'Exclude from Dunning Indicator';
        relevantIndicator      : Boolean @Common.Label: '1098 Relevant Indicator';

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
        conditionAmt        : String(15);
        paymentFromExactDay : String;
        frequencyInMonths   : String(4);
        dueDate             : Date;
        calculationDate     : Date;
        sequence            : Integer;
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
        documentNumber    : String @Common.Label: 'Document Line Number';
        loanCategory      : String  @Common.Label: 'Loan Category';
        flowType          : String  @Common.Label: 'Flow Type';
        orginalAount      : String  @Common.Label: 'Original Amount';
        text              : String  @Common.Label: 'Text';
        fund              : String  @Common.Label: 'Fund';
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
        disburseAmount         : String  @Common.Label: 'New Disburse Amount';
        flowType               : String  @Common.Label: 'Flow Type';
        grossAmount            : String  @Common.Label: 'Gross Amount'  default '0000'       @readonly;
        disbursementOblig      : String  @Common.Label: 'Disbursement Oblig.'  default '  '  @readonly;
        paymentDate            : Date    @Common.Label: 'Payment Date';
        effectiveDate          : Date    @Common.Label: 'Effective Date';
        bp                     : String  @Common.Label: 'BP';
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
entity paymentFromExactDaySearchHelp{
    key ID          : UUID;
        value       : String;
        description : String;
}
