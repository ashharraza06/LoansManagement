using {db} from '../db/schema';

service MyService {
    @odata.draft.enabled
    entity Contract                       as projection on db.Contract;
    entity ConditionItemsNew              as projection on db.ConditionItemsNew;
    entity Partners                       as projection on db.Partners;
    entity ConditionTypeTextSearchHelpNew as projection on db.ConditionTypeTextSearchHelpNew;
    entity Attachments as projection on db.Attachments;

}
