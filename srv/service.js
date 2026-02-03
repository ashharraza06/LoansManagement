const cds = require('@sap/cds');

module.exports = cds.service.impl(async function () {
    let { loanCategorySearchHelp, Earmark, Partners } = this.entities
    this.on('UPDATE', 'Earmark.drafts', async (req, next) => {
        debugger
        var category = req.data.loanCategory;
        if (category) {
            var data = await SELECT.from(loanCategorySearchHelp).where({ category: category })
            // req.data.flowType = data.flowtype;
            await UPDATE(Earmark.drafts)
                .set({
                    flowType: data[0].flowtype
                })
                .where({ earmarkId: req.data.earmarkId });



        }
        return next();
    }),
        this.after('CREATE', 'Contract.drafts', async (req, data) => {
            debugger
            var BPnumber = data.data.bpNumber;
            var partnerId = cds.utils.uuid();
            if (BPnumber) {
                await INSERT.into(Partners.drafts).entries({
                    partnerId: partnerId,
                    id: data.data.ID,   // or req.data.ID if you already have one
                    partner: BPnumber,
                    nameAddress: "Berks Barber School",
                    DraftAdministrativeData_DraftUUID:
                        data.data.DraftAdministrativeData_DraftUUID
                });
            }

        }),
        this.before('CREATE', 'Earmark.drafts', async (req, next) => {
            req.data.documentNumber =
                Math.floor(10 + Math.random() * 990);

        })

})
