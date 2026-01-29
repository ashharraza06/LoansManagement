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
    entity PaymentMethodSearchHelp as projection on db.PaymentMethodSearchHelp;
    entity ARBillingJobSearchHelp as projection on db.ARBillingJobSearchHelp;
    entity AmortizationStatusSearchHelp as projection on db.AmortizationStatusSearchHelp;
    


}
