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
    key ID                  : UUID;
        companyCode         : String  @Common.Label: 'Company Code';
    key loanNumber          : String  @mandatory  @Common.Label: 'Loan Number';
    key productType         : String  @mandatory  @Common.Label: 'Product Type';
    key loanType            : String  @mandatory  @Common.Label: 'Loan Type';
    key loanPartner         : String  @mandatory  @Common.Label: 'Loan Partner';

        status              : String;
        disbursementStatus  : String;

        /* ---------- Number Composition ---------- */
        // loanIndicator       : String(1);
        // numberRange         : String(10);
        // divider             : String(1);


        /* ---------- Basic Data ---------- */
        // //classification
        // loanTypeBD          : String(3);
        // Application/approval
        applicationDate     : Date;
        applicationCapital  : Decimal(15, 2);
        approvalDate        : Date;
        commitmentDate      : Date;

        /* ---------- Analysis Data ---------- */
        // Information
        loanPurpose         : String;
        arBillingJob        : String;

        /* ---------- Organization ---------- */
        // agentdata
        country             : String;
        orgDistrict         : String;
        agentDistrict       : String;

        /* ---------- Reference Data ---------- */
        // groupkey
        primaryIndustryCode : String;
        // other references
        legacyNumber        : String;
        projectNumber       : String;


        //conditions
        commitCapital       : String  @mandatory;
        repaymentType       : String;

        //term/fixed Period
        fixedFrom           : Date    @mandatory;
        fixedUntil          : Date    @mandatory;
        include             : Boolean;

        //Interest Calculation
        intCalMt            : String  @mandatory;
        postAdjustmentFlag  : Boolean;
        /* ---------- Associations ---------- */

        contractToCondition : Composition of many ConditionItemsNew
                                  on contractToCondition.contractId = ID;
        contractToPartner   : Composition of many Partners
                                  on contractToPartner.id = ID;
        contracttoAttachments : Composition of many Attachments on contracttoAttachments.contraid = ID;                          
}


//condition items according to cash flow
entity ConditionItemsNew : managed {
    key conditionId         : UUID;
        contractId          : UUID;
        conditionTypeText   : String(20);
        effectiveFrom       : Date;
        percentage          : String(4);
        conditionAmt        : String(15);
        paymentFromExactDay : String(20);
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
        partner           : String;
        bpRole            : String;

        roleType          : String;
        customer          : String;
        bankDetailsID     : String;

        dunningLetter     : String;
        dunnChargesPyr    : Boolean;
        paymentMethod     : Integer;
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
