sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"createloanoffer/test/integration/pages/LoansList",
	"createloanoffer/test/integration/pages/LoansObjectPage"
], function (JourneyRunner, LoansList, LoansObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('createloanoffer') + '/test/flp.html#app-preview',
        pages: {
			onTheLoansList: LoansList,
			onTheLoansObjectPage: LoansObjectPage
        },
        async: true
    });

    return runner;
});

