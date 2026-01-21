using {db} from '../db/schema';

service MyService {
    @odata.draft.enabled
    entity Loans as projection on db.Loans;
    entity conditionHeader as projection on db.ConditionHeaders;
    entity conditionLineItems as projection on db.ConditionLineItems;
    @odata.draft.enabled
    entity partners as projection on db.Partners;
    entity PartnerAttributes as projection on db.PartnerAttributes;

}