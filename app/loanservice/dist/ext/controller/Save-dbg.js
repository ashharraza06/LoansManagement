sap.ui.define([
    "sap/m/MessageToast"
], function(MessageToast) {
    'use strict';

    return {
        /**
         * Generated event handler.
         *
         * @param oContext the context of the page on which the event was fired. `undefined` for list report page.
         * @param aSelectedContexts the selected contexts of the table rows.
         */
        Save: function(oContext, aSelectedContexts) {
              var oSaveButton = sap.ui.getCore().byId(
                "loanservice::postingInvoicesObjectPage--fe::FooterBar::StandardAction::Save"
            );

            if (oSaveButton) {
                oSaveButton.firePress();   // Trigger button press
            } else {
                console.log("Save button not found");
            }
            // MessageToast.show("Save");
        }
    };
});
