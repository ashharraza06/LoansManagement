sap.ui.define(['sap/ui/core/mvc/ControllerExtension',
	"sap/ui/core/Control",
	"sap/ui/core/format/DateFormat"
], function (ControllerExtension, Control, DateFormat) {
	'use strict';

	/* ============================================================ */
	/* PostInvoices Form — 4 fixed columns                          */
	/* ============================================================ */
	function setFixedFormLayout() {

		/* SAPUI5 API — set columns */
		const sFormId = "loanservicing.loanservicing::postingInvoicesObjectPage--fe::Form::PostInvoices::Content";
		const oForm = sap.ui.getCore().byId(sFormId);

		if (oForm && oForm.getLayout) {
			const oLayout = oForm.getLayout();
			if (oLayout) {
				oLayout.setColumnsXL(4);
				oLayout.setColumnsL(4);
				oLayout.setColumnsM(4);
				if (oLayout.setColumnsS) oLayout.setColumnsS(4);
				if (oLayout.setMaxColumns) oLayout.setMaxColumns(4);
				if (oLayout.setAdjustLabelSpan) oLayout.setAdjustLabelSpan(false);
			}
		}

		/* DOM CSS hard-lock — prevents expanding beyond 4 cols on zoom out */
		const sContainerDomId = "loanservicing.loanservicing::postingInvoicesObjectPage--fe::FormContainer::PostInvoices";
		const oContainerDom = document.getElementById(sContainerDomId);

		if (!oContainerDom) {
			console.warn("PostInvoices DOM not found, retrying...");
			setTimeout(setFixedFormLayout, 500);
			return;
		}

		const oContentGrid = oContainerDom.closest(".sapUiFormCLContent");

		if (!oContentGrid) {
			console.warn("PostInvoices sapUiFormCLContent not found");
			return;
		}

		const styleId = "fixedLayout_PostInvoices";

		if (!document.getElementById(styleId)) {
			oContentGrid.classList.add("fixedFourColGrid");

			const style = document.createElement("style");
			style.id = styleId;
			style.textContent = [
				".fixedFourColGrid {",
				"  display: grid !important;",
				"  grid-template-columns: repeat(4, 1fr) !important;",
				"}",
				".fixedFourColGrid > .sapUiFormCLContainer {",
				"  width: 100% !important;",
				"  min-width: 0 !important;",
				"  grid-column: span 1 !important;",
				"}"
			].join("\n");

			document.head.appendChild(style);
			console.log("CSS injected — 4-col grid fixed on:", oContentGrid);
		}
	}

	/* ============================================================ */
	/* ProcessingIncomingPayments Form — 3 fixed columns (pending)  */
	/* ============================================================ */
	function setProcessingFormLayout() {

		const sContainerDomId = "loanservicing.loanservicing::postingInvoicesObjectPage--fe::FormContainer::ProcessingIncomingPayments";
		const oContainerDom = document.getElementById(sContainerDomId);

		if (!oContainerDom) {
			console.warn("ProcessingIncomingPayments DOM not found, retrying...");
			setTimeout(setProcessingFormLayout, 500);
			return;
		}

		const oContentGrid = oContainerDom.closest(".sapUiFormCLContent");

		if (!oContentGrid) {
			console.warn("ProcessingIncomingPayments sapUiFormCLContent not found");
			return;
		}

		const styleId = "fixedLayout_ProcessingIncomingPayments";

		if (!document.getElementById(styleId)) {
			oContentGrid.classList.add("fixedThreeColGrid");

			const style = document.createElement("style");
			style.id = styleId;
			style.textContent = [
				".fixedThreeColGrid {",
				"  display: grid !important;",
				"  grid-template-columns: repeat(3, 1fr) !important;",
				"}",
				".fixedThreeColGrid > .sapUiFormCLContainer {",
				"  width: 100% !important;",
				"  min-width: 0 !important;",
				"  grid-column: span 1 !important;",
				"}"
			].join("\n");

			document.head.appendChild(style);
			console.log("CSS injected — 3-col grid fixed on:", oContentGrid);
		}
	}

	return ControllerExtension.extend('loanservicing.loanservicing.ext.controller.Objpage', {

		override: {
			/**
			 * Called when a controller is instantiated and its View controls (if available) are already created.
			 * @memberOf loanservicing.loanservicing.ext.controller.Objpage
			 */
			onInit: function () {
				debugger;
				var oModel = this.base.getExtensionAPI().getModel();
				this._setupDateObserver();
			},

			routing: {
				onAfterBinding: function () {
					debugger;
					this._formatEditDates();
					this._formatDisplayDates();

					setTimeout(setFixedFormLayout, 600);
					setTimeout(setProcessingFormLayout, 700);
				}
			}
		},

		_formatEditDates: function () {

			const oView = this.base.getView();
			if (!oView) return;

			this._walkControls(oView, oControl => {

				if (oControl.isA && oControl.isA("sap.m.DatePicker")) {

					const oBinding = oControl.getBinding("value");

					if (oBinding) {
						const sPath = oBinding.getPath();
						oControl.unbindProperty("value");
						oControl.bindProperty("dateValue", { path: sPath });
					}

					oControl.setDisplayFormat("MM/dd/yyyy");
					oControl.setValueFormat("yyyy-MM-dd");
				}
			});
		},

		_formatDisplayDates: function () {

			const oFormatter = DateFormat.getDateInstance({
				pattern: "MM/dd/yyyy"
			});

			document.querySelectorAll("[id$='Field-display'], .sapMText").forEach(el => {

				const sText = el.innerText?.trim();
				if (!sText) return;
				if (/^\d{2}\/\d{2}\/\d{4}$/.test(sText)) return;

				const m = sText.match(/^([A-Za-z]{3}) (\d{1,2}), (\d{4})$/);
				if (!m) return;

				const oDate = new Date(`${m[1]} ${m[2]}, ${m[3]}`);
				if (isNaN(oDate)) return;

				el.innerText = oFormatter.format(oDate);
			});
		},

		_setupDateObserver: function () {

			const observer = new MutationObserver(() => {
				this._formatDisplayDates();
			});

			observer.observe(document.body, {
				childList: true,
				subtree: true
			});
		},

		_walkControls: function (oControl, fnCallback) {

			fnCallback(oControl);
			if (!oControl.getAggregation) return;

			const mAggs = oControl.getMetadata().getAllAggregations();

			Object.keys(mAggs).forEach(sAgg => {

				const oAgg = oControl.getAggregation(sAgg);

				if (Array.isArray(oAgg)) {
					oAgg.forEach(c => this._walkControls(c, fnCallback));
				} else if (oAgg instanceof Control) {
					this._walkControls(oAgg, fnCallback);
				}
			});
		}
	});
});