sap.ui.define(['sap/ui/core/mvc/ControllerExtension'], function (ControllerExtension) {
	'use strict';

	return ControllerExtension.extend('loanoffercreation.ext.controller.Contractobj', {
		// this section allows to extend lifecycle hooks or hooks provided by Fiori elements
		override: {
			/**
			 * Called when a controller is instantiated and its View controls (if available) are already created.
			 * Can be used to modify the View before it is displayed, to bind event handlers and do other one-time initialization.
			 * @memberOf loanoffercreation.ext.controller.Contractobj
			 */
			onInit: function () {
				// you can access the Fiori elements extensionAPI via this.base.getExtensionAPI
				var oModel = this.base.getExtensionAPI().getModel();
				debugger;
				
			},
			routing: {
				onAfterBinding: async function () {

					debugger;

					// var Incomingpayment = sap.ui.core.Element.getElementById('loanoffercreation::ContractObjectPage--fe::CustomSubSection::Incomingpayment');
					// Incomingpayment.setVisible(false);

					// var oSelectedObject = sap.ui.core.Element.getElementById("loanoffercreation::ContractObjectPage--fe::table::contractToPartner::LineItem::Partners-innerTable").getBindingContext().getObject();

					// var odata = new sap.ui.model.json.JSONModel({
					// 	paymentMethod: oSelectedObject.paymentMethod,
					// 	arBillingJob: oSelectedObject.arBillingJob,
					// 	payoffLock: oSelectedObject.payoffLock,
					// 	relevantIndicator: oSelectedObject.relevantIndicator,
					// 	dunningIndicator: oSelectedObject.dunningIndicator
					// }
					// );

					// var oSection = sap.ui.core.Element.getElementById('loanoffercreation::ContractObjectPage--fe::CustomSubSection::Incomingpayment');
					// oSection.setModel(odata, 'incomingPay');
					sap.ui.getCore().byId("loanoffercreation::ContractObjectPage--fe::ObjectPage-anchBar-loanoffercreation::ContractObjectPage--fe::FacetSection::Partners-anchor").attachEvent("press", function (oEvent) {
						debugger
						var oSelectedObject = sap.ui.core.Element.getElementById("loanoffercreation::ContractObjectPage--fe::table::contractToPartner::LineItem::Partners-innerTable").getBindingContext().getObject();

					var odata = new sap.ui.model.json.JSONModel({
						paymentMethod: oSelectedObject.paymentMethod,
						arBillingJob: oSelectedObject.arBillingJob,
						payoffLock: oSelectedObject.payoffLock,
						relevantIndicator: oSelectedObject.relevantIndicator,
						dunningIndicator: oSelectedObject.dunningIndicator
					}
					);

					var oSection = sap.ui.core.Element.getElementById('loanoffercreation::ContractObjectPage--fe::CustomSubSection::Incomingpayment');
					oSection.setModel(odata, 'incomingPay');
					}
				)
					sap.ui.getCore().byId("loanoffercreation::ContractObjectPage--fe::ObjectPage-anchBar-loanoffercreation::ContractObjectPage--fe::FacetSection::Partners-anchor").attachEvent("click", function (oEvent) {
						debugger
						var oSelectedObject = sap.ui.core.Element.getElementById("loanoffercreation::ContractObjectPage--fe::table::contractToPartner::LineItem::Partners-innerTable").getBindingContext().getObject();

					var odata = new sap.ui.model.json.JSONModel({
						paymentMethod: oSelectedObject.paymentMethod,
						arBillingJob: oSelectedObject.arBillingJob,
						payoffLock: oSelectedObject.payoffLock,
						relevantIndicator: oSelectedObject.relevantIndicator,
						dunningIndicator: oSelectedObject.dunningIndicator
					}
					);

					var oSection = sap.ui.core.Element.getElementById('loanoffercreation::ContractObjectPage--fe::CustomSubSection::Incomingpayment');
					oSection.setModel(odata, 'incomingPay');
					}
				)

				}
			}
		}
	});
});
