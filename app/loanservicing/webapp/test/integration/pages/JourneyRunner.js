sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"loanservicing/loanservicing/test/integration/pages/postingInvoicesList",
	"loanservicing/loanservicing/test/integration/pages/postingInvoicesObjectPage"
], function (JourneyRunner, postingInvoicesList, postingInvoicesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('loanservicing/loanservicing') + '/test/flp.html#app-preview',
        pages: {
			onThepostingInvoicesList: postingInvoicesList,
			onThepostingInvoicesObjectPage: postingInvoicesObjectPage
        },
        async: true
    });

    return runner;
});

