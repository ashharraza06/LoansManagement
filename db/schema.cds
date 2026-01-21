namespace db;


using {
    cuid,
    managed
} from '@sap/cds/common';

/* =========================
   ROOT LOAN ENTITY
========================= */
entity Loans :managed {
    /* ---------- Step 1 : Initial Screen ---------- */
   key companyCode         : String(4) @Common.Label: 'Company Code';
   key productType         : String(3)@Common.Label: 'Product Type';// HL / PL
   key businessPartner     : String(20)@Common.Label: 'BPartner';

    /* ---------- Number Composition ---------- */
    loanIndicator       : String(1) ;
    numberRange         : String(10) ; 
    divider             : String(1) ;
    loanTypeNC          : String(3); // TL / OD

    /* ---------- Basic Data ---------- */
    //classification
    loanTypeBD          : String(3);
    // Application/approval
    applicationDate     : Date;
    applicationCapital  : Decimal(15, 2);
    approvalDate        : Date;
    commitmentDate      : Date;

    /* ---------- Analysis Data ---------- */
    // Information
    loanPurpose         : String(4);
    arBillingJob        : String(10);

    /* ---------- Organization ---------- */
    // agentdata
    country             : String(3);
    orgDistrict         : String(10);
    agentDistrict       : String(10);

    /* ---------- Reference Data ---------- */
    // groupkey
    primaryIndustryCode : String(10);
    // other references
    legacyNumber        : String(20);
    projectNumber       : String(20);

    /* ---------- Associations ---------- */
    conditionHeader     : Association to one ConditionHeaders
                              on conditionHeader.loan = $self;

    conditionLineItems  : Association to many ConditionLineItems
                              on conditionLineItems.loan = $self;

    partners            : Association to many Partners
                              on partners.loan = $self;
    partnerattr         : Association to many PartnerAttributes on partnerattr.partner = $self                          
}

entity ConditionHeaders : cuid, managed {


    commitCapital : Decimal(15, 2);
    repaymentType : String(20);
    //term/fixed period
    termStart     : Date;
    fixedFrom     : Date;
    fixedUntil    : Date;
    termEnd       : Date;
    //intrest calculation
    intCalMethod  : String(30);
    EffectInt : String(20);
    // contract/Eff.Int
    contract : String;
    contracton : Date;
    Amtzdate : Date;
    // ------------
    maturitydate : Date;
    loan          : Association to Loans;
}
entity ConditionLineItems : cuid, managed {
    

    condTypeText       : String(50);
    effFrom            : Date;

    percent            : Decimal(9,6);
    conditionAmount    : Decimal(15,2);

    currency           : String(3);

    lvl                : String(1);
    Is                 : Boolean;

    pf                 : Integer;
    pe                 : String(2);

    frequency          : Integer;
    dueOn              : Date;

    ed                 : Boolean;
    calcDate           : Date;
    mc                 : Boolean;

    formula            : String(10);
    loan               : Association to Loans;
}
entity Partners : cuid, managed {

    title           : String(20);
    nameAddress     : String(255);

    startRel        : Date;
    endRel          : Date;

    addressType     : String(10);
    partner         : String(20);
    bpRole          : String(20);
    loan            : Association to Loans;
}
entity PartnerAttributes : cuid, managed {
    

    roleType         : String(20);
    customer         : String(20);
    bankDetailsID    : String(20);

    dunningLetter    : String;
    dunnChargesPyr   : Boolean;
    paymentMethod    : Integer;
    partner          : Association to Loans;
}



