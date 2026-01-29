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
        onPress: function (oEvent) {
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
                console.log('LOGGED',sPath);
                var oNewContext = oSection.getModel().createBindingContext(sPath);
                oSection.setBindingContext(oNewContext);


                // example: do nothing or reuse existing context
            } else {
                // Path is still Contract root – build new navigation path


                var contractID = oSectionContext.getProperty("ID");

                var newpath = path +
                    `/contractToPartner(id=${contractID},partnerId=${oSelectedObject.partnerId},IsActiveEntity=${oSelectedObject.IsActiveEntity})`;

                var oNewContext = oSection.getModel().createBindingContext(newpath);
                oSection.setBindingContext(oNewContext);
            }



            // const sPath =
            //     `/ Contract(ID = 11111111 - 1111 - 1111 - 1111 - 111111111111, loanNumber = 'LN001', productType = 'AG01', loanType = 'LT01', loanPartner = 'BANK01', IsActiveEntity = true) / contractToPartner(id = '11111111-1111-1111-1111-111111111111', partnerId = 'p1111111-1111-1111-1111-pppppppp1111', IsActiveEntity = true)`

            var path1 = sap.ui.core.Element.getElementById('loanoffercreation::ContractObjectPage--fe::CustomSubSection::Incomingpayment').getBindingContext().sPath;

            // oBinding.requestObject().then(function (oData) {
            //     console.log("Full Partner data:", oData);

            //     var odata = new sap.ui.model.json.JSONModel({
            //         paymentMethod: oData.paymentMethod,
            //         arBillingJob: oData.arBillingJob,
            //         payoffLock: oData.payoffLock,
            //         relevantIndicator: oData.relevantIndicator,
            //         dunningIndicator: oData.dunningIndicator
            //     }
            //     );

            //     oSection.setModel(odata, 'incomingPay');
            // });



        }
    };
});
