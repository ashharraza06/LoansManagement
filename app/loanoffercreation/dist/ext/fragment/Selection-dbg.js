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
            var Incomingpayment = sap.ui.core.Element.getElementById('loanoffercreation::ContractObjectPage--fe::CustomSubSection::Incomingpayment');
            // Incomingpayment.setVisible(true);
            debugger;
            var oSelectedObject = oEvent.getSource().getBindingContext().getObject();
            var oModel = oEvent.getSource().getBindingContext().getModel();
             var oSection = sap.ui.core.Element.getElementById('loanoffercreation::ContractObjectPage--fe::CustomSubSection::Incomingpayment');
            // var odata;

            // this.byId("IncomingPaymentForm").setBindingContext(oContext);

            const sPath = `/Partners(partnerId=${oSelectedObject.partnerId},IsActiveEntity=${oSelectedObject.IsActiveEntity})`;
            const oBinding = oModel.bindContext(sPath);

            oBinding.requestObject().then(function (oData) {
                console.log("Full Partner data:", oData);

                var odata = new sap.ui.model.json.JSONModel({
                    paymentMethod: oData.paymentMethod,
                    arBillingJob: oData.arBillingJob,
                    payoffLock: oData.payoffLock,
                    relevantIndicator: oData.relevantIndicator,
                    dunningIndicator: oData.dunningIndicator
                }
                );
               
                oSection.setModel(odata, 'incomingPay');
            });

            // var oSection = sap.ui.core.Element.getElementById('loanoffercreation::ContractObjectPage--fe::CustomSubSection::Incomingpayment');
            // oSection.setModel(odata, 'incomingPay');


        }
    };
});
