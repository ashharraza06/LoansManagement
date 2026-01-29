
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
					// sap.ui.core.Element.getElementById("__button8-__clone81").firePress();

				},
				onAfterRendering : function(){
					debugger;
					var oTable= sap.ui.core.Element.getElementById("loanoffercreation::ContractObjectPage--fe::table::contractToPartner::LineItem::Partners");
					if (oTable.getItems().Length>0){

					}
				}
			}
		}
	});
});
