using {db} from '../db/schema';

service MyService {
    @odata.draft.enabled
    entity Contract                       as projection on db.Contract;

    entity ConditionItemsNew              as projection on db.ConditionItemsNew;
    entity Partners                       as projection on db.Partners;
    entity ConditionTypeTextSearchHelpNew as projection on db.ConditionTypeTextSearchHelpNew;
    entity Attachments                    as projection on db.Attachments;
    entity EntityAuditLogs                as projection on db.EntityAuditLogs;
    entity Changes                        as projection on db.Changes;
    entity Earmark                        as projection on db.Earmark;


    entity Disbursement                   as projection on db.Disbursement;

    entity PaymentMethodSearchHelp        as projection on db.PaymentMethodSearchHelp;
    entity ARBillingJobSearchHelp         as projection on db.ARBillingJobSearchHelp;
    entity AmortizationStatusSearchHelp   as projection on db.AmortizationStatusSearchHelp;
    entity loanCategorySearchHelp         as projection on db.loanCategorySearchHelp;
    entity paymentFromExactDaySearchHelp  as projection on db.paymentFromExactDaySearchHelp;
    entity intCalMtSearchHelp             as projection on db.intCalMtSearchHelp;
    entity reasonSearchHelp               as projection on db.reasonSearchHelp;


};

service LoanServicing {
    @odata.draft.enabled
    entity postingInvoices          as projection on db.postingInvoices;

    entity contractIncomingPayments as projection on db.contractIncomingPayments;
    entity productType              as projection on db.productType;
    entity loanType                 as projection on db.loanType;
    entity flowType                 as projection on db.flowType;
    entity loanTypeSearchHelp       as projection on db.loanTypeSearchHelp;
    entity productTypeSearchHelp    as projection on db.productTypeSearchHelp;
    entity flowTypeSearchHelp       as projection on db.flowTypeSearchHelp;

}

service LoanServicing1 {
    @odata.draft.enabled
    entity postingInvoices          as projection on db.postingInvoices;

    entity contractIncomingPayments as projection on db.contractIncomingPayments;
    entity productType              as projection on db.productType;
    entity loanType                 as projection on db.loanType;
    entity flowType                 as projection on db.flowType;
    entity loanTypeSearchHelp       as projection on db.loanTypeSearchHelp;
    entity productTypeSearchHelp    as projection on db.productTypeSearchHelp;
    entity flowTypeSearchHelp       as projection on db.flowTypeSearchHelp;
    entity paymentMethod1           as projection on db.paymentMethod1;
    entity paymentMethodSearchHelp1 as projection on db.paymentMethodSearchHelp1;
    entity contractNo           as projection on db.contractNo;
    entity contractNoSearchHelp as projection on db.contractNoSearchHelp;
    entity transactionSearchHelp as projection on db.transactionSearchHelp  ;
    entity pledgedStatus           as projection on db.pledgedStatus;
    entity pledgedStatusSearchHelp as projection on db.pledgedStatusSearchHelp;
    entity PaymentMethodSearchHelp as projection on db.PaymentMethodSearchHelp;
    

}
