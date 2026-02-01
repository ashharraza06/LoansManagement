sap.ui.define([
    "sap/ui/core/mvc/ControllerExtension",
    "sap/ui/core/Control",
    "sap/ui/core/format/DateFormat"
], function (ControllerExtension, Control, DateFormat) {
    "use strict";

    return ControllerExtension.extend("loanoffercreation.ext.controller.Contractobj", {

        /* ===================================================== */
        /* FE lifecycle hooks                                   */
        /* ===================================================== */

        override: {

            onInit: function () {
                this._setupDateObserver();
            },

            onAfterRendering: function () {
                this._attachAnchorBarClick();
                this._formatDisplayDates();
            },

            routing: {
                onAfterBinding: function () {
                    this._formatEditDates();
                    this._formatDisplayDates();
                }
            }
        },

        /* ===================================================== */
        /* EDIT MODE → DatePicker                               */
        /* ===================================================== */

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

        /* ===================================================== */
        /* DISPLAY MODE → Non-table fields                      */
        /* ===================================================== */

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

        /* ===================================================== */
        /* Mutation Observer                                    */
        /* ===================================================== */

        _setupDateObserver: function () {
            const observer = new MutationObserver(() => {
                this._formatDisplayDates();
            });

            observer.observe(document.body, {
                childList: true,
                subtree: true
            });
        },

        /* ===================================================== */
        /* Control Walker                                       */
        /* ===================================================== */

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
        },

        /* ===================================================== */
        /* Anchor Bar Click → Table Date Formatting              */
        /* ===================================================== */

        _attachAnchorBarClick: function () {
            const sId = "loanoffercreation::ContractObjectPage--fe::ObjectPage-anchBar";
            const oAnchorBar = document.getElementById(sId);
            if (!oAnchorBar) return;

            if (oAnchorBar.dataset.feClickAttached === "true") return;
            oAnchorBar.dataset.feClickAttached = "true";

            oAnchorBar.addEventListener("click", () => {
                this._formatAllFacetTables();
            });
        },

        /* ===================================================== */
        /* Facet → Column mapping                               */
        /* ===================================================== */

        _formatAllFacetTables: function () {

            const mFacetConfig = {
                "loanoffercreation::ContractObjectPage--fe::FacetSubSection::ConditionItems": [1, 6, 7],
                "loanoffercreation::ContractObjectPage--fe::FacetSubSection::Partners2": [5, 6],   // ✅ FIX
                "loanoffercreation::ContractObjectPage--fe::FacetSubSection::Disbursements": [2, 3]
            };


            Object.keys(mFacetConfig).forEach(sFacetId => {
                this._formatFacetTable(sFacetId, mFacetConfig[sFacetId]);
            });
        },

        _formatFacetTable: function (sFacetId, aDateIndexes) {
            const oFacet = sap.ui.getCore().byId(sFacetId);
            if (!oFacet) return;

            let oInnerTable;
            try {
                oInnerTable =
                    oFacet.mAggregations._grid
                        .mAggregations.content[0]
                        .mAggregations.content
                        .mAggregations.content
                        .mAggregations._content;
            } catch (e) { }

            if (!oInnerTable) {
                setTimeout(() => this._formatFacetTable(sFacetId, aDateIndexes), 500);
                return;
            }

            if (oInnerTable._dateFormattingAttached) return;
            oInnerTable._dateFormattingAttached = true;

            const fnFormat = () => {
                this._updateRows(oInnerTable, aDateIndexes);
            };

            if (oInnerTable.isA("sap.m.Table")) {
                oInnerTable.attachUpdateFinished(fnFormat);
            } else if (oInnerTable.isA("sap.ui.table.Table")) {
                oInnerTable.attachRowsUpdated(fnFormat);
            }

            fnFormat();
        },

        _updateRows: function (oInnerTable, aDateIndexes) {

            if (oInnerTable.isA("sap.m.Table")) {
                const aItems = oInnerTable.getItems();
                if (!aItems || aItems.length === 0) return;

                aItems.forEach(oItem => {
                    const aCells = oItem.getCells();
                    if (!aCells) return;

                    aDateIndexes.forEach(iIdx => {
                        if (aCells[iIdx]) {
                            this._formatDateCell(aCells[iIdx]);
                        }
                    });
                });
                return;
            }

            if (oInnerTable.isA("sap.ui.table.Table")) {
                const aRows = oInnerTable.getRows();
                if (!aRows || aRows.length === 0) return;

                aRows.forEach(oRow => {
                    const aCells = oRow.getCells();
                    if (!aCells) return;

                    aDateIndexes.forEach(iIdx => {
                        if (aCells[iIdx]) {
                            this._formatDateCell(aCells[iIdx]);
                        }
                    });
                });
            }
        },

        _formatDateCell: function (oCell) {
            if (!oCell) return;

            // ===== Edit mode =====
            const oDatePicker = oCell?.mAggregations?.content?.mAggregations?.contentEdit?.[0];
            if (oDatePicker && oDatePicker.setDisplayFormat) {
                const oBinding = oDatePicker.getBinding("value");
                if (oBinding) {
                    const sPath = oBinding.getPath();
                    oDatePicker.unbindProperty("value");
                    oDatePicker.bindProperty("dateValue", { path: sPath });
                }
                oDatePicker.setDisplayFormat("MM/dd/yyyy");
                oDatePicker.setValueFormat("yyyy-MM-dd");
                return;
            }

            // ===== Display mode =====
            const oText = oCell?.mAggregations?.content?.mAggregations?.contentDisplay;
            if (!oText || !oText.getText) return;

            const sText = oText.getText();
            if (!sText) return;
            if (/^\d{2}\/\d{2}\/\d{4}$/.test(sText)) return;

            const oSourceFormatter = DateFormat.getDateInstance({ pattern: "MMM dd yyyy" });
            const oTargetFormatter = DateFormat.getDateInstance({ pattern: "MM/dd/yyyy" });

            const oDate = oSourceFormatter.parse(sText);
            if (!oDate) return;

            oText.setText(oTargetFormatter.format(oDate));
        }

    });
});
