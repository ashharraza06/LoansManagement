sap.ui.define([
	"sap/ui/core/mvc/ControllerExtension",
	"sap/ui/core/Control",
	"sap/ui/core/format/DateFormat",
	"sap/m/BusyDialog"
], function (ControllerExtension, Control, DateFormat, BusyDialog) {
	"use strict";

	const oFormatter = DateFormat.getDateInstance({ pattern: "MM/dd/yyyy" });
	const MON_RE = /^([A-Za-z]{3}) (\d{1,2}), (\d{4})$/;
	const US_RE = /^\d{2}\/\d{2}\/\d{4}$/;

	let oBusy;
	let initialFormattingDone = false;

	function formatEl(el) {
		const sText = el.innerText?.trim();
		if (!sText || US_RE.test(sText)) return;

		const m = sText.match(MON_RE);
		if (!m) return;

		const oDate = new Date(`${m[1]} ${m[2]}, ${m[3]}`);
		if (!isNaN(oDate)) el.innerText = oFormatter.format(oDate);
	}

	/* ============================================================ */
	/* Column Layout (same logic as your first controller)          */
	/* ============================================================ */
	function setFixedFormLayout() {

		/* SAPUI5 API — set columns */
		const sFormId = "loanservice::postingInvoicesObjectPage--fe::Form::PostInvoice::Content";
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
		const sContainerDomId = "loanservice::postingInvoicesObjectPage--fe::Form::PostInvoice";
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


	return ControllerExtension.extend("loanservice.ext.controller.PostObj", {

		override: {

			onInit: function () {

				// oBusy = new BusyDialog({
				//     text: "Formatting dates..."
				// });

				// oBusy.open();

				this._waitUntilReady();
				this._attachTabChangeListener();
			},

			routing: {

				onAfterBinding: function () {
					debugger;
					var url = window.location.href;
					var isActiveEntity = url.match(/IsActiveEntity=(true|false)/)[1] === "true";

					console.log(isActiveEntity);
					sap.ui.core.Element.getElementById("loanservice::postingInvoicesObjectPage--fe::CustomAction::save").setEnabled(!isActiveEntity)
					setTimeout(() => {
						setFixedFormLayout();
						this._formatEditDates();
						this._formatDisplayDates();
					}, 200);

				}

			}

		},

		/* ---------------------------------------------------------- */
		/* Wait until first tab is rendered                          */
		/* ---------------------------------------------------------- */

		_waitUntilReady: function () {

			const tryRun = () => {

				const el = document.querySelector("[id$='PostInvoice::Content']");

				if (!el) {
					setTimeout(tryRun, 200);
					return;
				}

				this._formatEditDates();
				this._formatDisplayDates();

				if (!initialFormattingDone) {

					initialFormattingDone = true;

					if (oBusy) {
						oBusy.close();
					}

				}

			};

			tryRun();
		},

		/* ---------------------------------------------------------- */
		/* Detect tab change (lazy loaded sections)                  */
		/* ---------------------------------------------------------- */

		_attachTabChangeListener: function () {

			const tryAttach = () => {

				const oTabBar = sap.ui.getCore().byId(
					"loanservice::postingInvoicesObjectPage--fe::ObjectPage-anchBar"
				);

				if (!oTabBar) {
					setTimeout(tryAttach, 300);
					return;
				}

				oTabBar.attachSelect(() => {

					setTimeout(() => {
						this._formatEditDates();
						this._formatDisplayDates();
					}, 150);

				});

			};

			tryAttach();
		},

		/* ---------------------------------------------------------- */
		/* Edit mode DatePicker formatting                           */
		/* ---------------------------------------------------------- */

		_formatEditDates: function () {

			const oPage = sap.ui.getCore().byId(
				"loanservice::postingInvoicesObjectPage--fe::ObjectPage"
			);

			if (!oPage) return;

			this._walkDatePickers(oPage);
		},

		_walkDatePickers: function (oControl) {

			if (!oControl) return;

			if (oControl.isA?.("sap.m.DatePicker")) {

				const oBinding = oControl.getBinding("value");

				if (oBinding) {
					const sPath = oBinding.getPath();

					oControl.unbindProperty("value");
					oControl.bindProperty("dateValue", { path: sPath });
				}

				oControl.setDisplayFormat("MM/dd/yyyy");
				oControl.setValueFormat("yyyy-MM-dd");

				return;
			}

			if (!oControl.getAggregation) return;

			const mAggs = oControl.getMetadata().getAllAggregations();

			for (const sAgg of Object.keys(mAggs)) {

				const oAgg = oControl.getAggregation(sAgg);

				if (Array.isArray(oAgg)) {
					oAgg.forEach(c => this._walkDatePickers(c));
				} else if (oAgg instanceof Control) {
					this._walkDatePickers(oAgg);
				}

			}

		},

		/* ---------------------------------------------------------- */
		/* Display mode formatting                                   */
		/* ---------------------------------------------------------- */

		_formatDisplayDates: function () {

			document
				.querySelectorAll("[id$='Field-display'], .sapMText")
				.forEach(el => formatEl(el));

		}

	});

});