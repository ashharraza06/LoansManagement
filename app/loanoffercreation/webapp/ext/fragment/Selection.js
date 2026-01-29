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
            var contractID = oSectionContext.getProperty("ID");
            var newpath = path + `/contractToPartner(id=${contractID},partnerId=${oSelectedObject.partnerId},IsActiveEntity=${oSelectedObject.IsActiveEntity})`
            // var odata;

            // this.byId("IncomingPaymentForm").setBindingContext(oContext);

            // const sPath = `/ Partners(partnerId = ${ oSelectedObject.partnerId }, IsActiveEntity = ${ oSelectedObject.IsActiveEntity })`;


            // const sPath =
            //     `/ Contract(ID = 11111111 - 1111 - 1111 - 1111 - 111111111111, loanNumber = 'LN001', productType = 'AG01', loanType = 'LT01', loanPartner = 'BANK01', IsActiveEntity = true) / contractToPartner(id = '11111111-1111-1111-1111-111111111111', partnerId = 'p1111111-1111-1111-1111-pppppppp1111', IsActiveEntity = true)`
            // const oBinding = oSection.getModel().bindContext(newpath);
            // oSection.bindElement({
            //     sPath: newpath
            // });
            var oNewContext = oSection.getModel().createBindingContext(newpath);

            oSection.setBindingContext(oNewContext);
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

            // var oSection = sap.ui.core.Element.getElementById('loanoffercreation::ContractObjectPage--fe::CustomSubSection::Incomingpayment');
            // oSection.setModel(odata, 'incomingPay');


        }
    };
});
