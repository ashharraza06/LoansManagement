sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"loanoffercreation/test/integration/pages/ContractList",
	"loanoffercreation/test/integration/pages/ContractObjectPage",
	"loanoffercreation/test/integration/pages/PartnersObjectPage"
], function (JourneyRunner, ContractList, ContractObjectPage, PartnersObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('loanoffercreation') + '/test/flp.html#app-preview',
        pages: {
			onTheContractList: ContractList,
			onTheContractObjectPage: ContractObjectPage,
			onThePartnersObjectPage: PartnersObjectPage
        },
        async: true
    });

    return runner;
});

