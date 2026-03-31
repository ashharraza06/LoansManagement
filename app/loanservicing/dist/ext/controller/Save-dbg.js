sap.ui.define([
    "sap/m/MessageToast"
], function (MessageToast) {
    'use strict';

    return {

        save: function (oContext, aSelectedContexts) {

            MessageToast.show("Custom handler invoked");

            // Get Save button
            var oSaveButton = sap.ui.getCore().byId(
                "loanservicing.loanservicing::postingInvoicesObjectPage--fe::FooterBar::StandardAction::Save"
            );

            debugger;
            if (oSaveButton) {
                console.log(oSaveButton);
                // oSaveButton.firePress();   // Trigger button press
            } else {
                console.log("Save button not found");
            }
        }

    };
});