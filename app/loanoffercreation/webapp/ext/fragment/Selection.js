sap.ui.define([
    "sap/m/MessageToast"
], function (MessageToast) {
    'use strict';

    return {
        /**
         * Generated event handler.
         *
         * @param oEvent the event object provided by the event provider.
         */
        onPress: async function (oEvent) {
            var oSection = sap.ui.core.Element.getElementById('loanoffercreation::ContractObjectPage--fe::CustomSubSection::Incomingpayment');
            // Incomingpayment.setVisible(true);
            debugger;
            var oSelectedObject = oEvent.getSource().getBindingContext().getObject();
            var oSectionContext = sap.ui.core.Element.getElementById('loanoffercreation::ContractObjectPage--fe::CustomSubSection::Incomingpayment').getBindingContext();
            var oModel = oEvent.getSource().getBindingContext().getModel();
            var path = sap.ui.core.Element.getElementById('loanoffercreation::ContractObjectPage--fe::CustomSubSection::Incomingpayment').getBindingContext().sPath;
            if (path && path.includes("contractToPartner")) {

                // Path already points to contractToPartner
                console.log("Already in contractToPartner context:", path);
                var partnerId = oSelectedObject.partnerId;
                var sPath = path.replace(
                    /partnerId=[0-9a-fA-F-]{36}/,
                    "partnerId=" + partnerId
                );
                console.log('LOGGED', sPath);
                var oNewContext = oSection.getModel().createBindingContext(sPath);
                oSection.setBindingContext(oNewContext);
            } else {
                var contractID = oSectionContext.getProperty("ID");
                var newpath = path +
                    `/contractToPartner(id=${contractID},partnerId=${oSelectedObject.partnerId},IsActiveEntity=${oSelectedObject.IsActiveEntity})`;
                debugger
                var oBinding = oSection.getModel().bindContext(newpath);

                await oBinding.requestObject();   // ✅ force latest
                oSection.setBindingContext(oBinding.getBoundContext());

            }

            var path1 = sap.ui.core.Element.getElementById('loanoffercreation::ContractObjectPage--fe::CustomSubSection::Incomingpayment').getBindingContext().sPath;
            console.log("changedpath",path1);
        }
    };
});
