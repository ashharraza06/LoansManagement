sap.ui.define([
    "sap/fe/test/JourneyRunner",
	"loanservice/test/integration/pages/postingInvoicesObjectPage"
], function (JourneyRunner, postingInvoicesObjectPage) {
    'use strict';

    var runner = new JourneyRunner({
        launchUrl: sap.ui.require.toUrl('loanservice') + '/test/flp.html#app-preview',
        pages: {
			onThepostingInvoicesObjectPage: postingInvoicesObjectPage
        },
        async: true
    });

    return runner;
});

