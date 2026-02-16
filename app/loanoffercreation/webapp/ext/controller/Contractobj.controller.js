sap.ui.define([

    "sap/ui/core/mvc/ControllerExtension",

    "sap/ui/core/Control",

    "sap/ui/core/format/DateFormat"

], function (ControllerExtension, Control, DateFormat) {

    "use strict";
    function setFixedFormLayout() {

        debugger;

        const aFormIds = [

            "loanoffercreation::ContractObjectPage--fe::Form::Form::Content",

            "loanoffercreation::ContractObjectPage--fe::Form::_1::Content",
            "loanoffercreation::ContractObjectPage--fe::Form::TermFixedPeriod::Content"

        ];


        aFormIds.forEach(function (sFormId) {

            const oForm = sap.ui.getCore().byId(sFormId);

            if (!oForm || !oForm.getLayout) return;

            const oLayout = oForm.getLayout();

            if (!oLayout) return;


            /* ⭐ FORCE 3 COLUMNS ALWAYS */

            oLayout.setColumnsXL(3);

            oLayout.setColumnsL(3);

            oLayout.setColumnsM(3);


            /* ⭐ VERY IMPORTANT FOR ColumnLayout */

            if (oLayout.setMaxColumns) {

                oLayout.setMaxColumns(3);

            }


            /* ⭐ prevent auto adjustment */

            if (oLayout.setAdjustLabelSpan) {

                oLayout.setAdjustLabelSpan(false);

            }

        });

    }

    function setWidth() {

        const mTables = {
            // partner: {
            //     id: "loanoffercreation::ContractObjectPage--fe::table::contractToPartner::LineItem::Partners-innerTable",
            //     widths: ["8rem", "10rem", "8rem", "8rem", "6rem", "8rem", "8rem"]
            // },

            earmark: {
                id: "loanoffercreation::ContractObjectPage--fe::table::contractToEarmark::LineItem::_-innerTable",
                widths: [
                    "6rem",
                    "15rem",
                    "4rem",
                    "8rem",
                    "8rem",
                    "5rem",
                    "7rem",
                    "8rem",
                    "8rem"
                ],
                forceFixed: true   // ⭐ grid fix
            },

            // disbursement: {
            //     id: "loanoffercreation::ContractObjectPage--fe::table::contractToDisbursement::LineItem::Disbursements-innerTable",
            //     widths: ["6rem", "10rem", "10rem", "10rem", "10rem", "10rem", "10rem"]
            // },

            condition: {
                id: "loanoffercreation::ContractObjectPage--fe::table::contractToCondition::LineItem::ConditionItems-innerTable",
                widths: [
                    "7rem", "8rem", "5rem", "7rem",
                    "14rem", "8rem", "8.2rem", "8.2rem", "7rem"
                ]
            }
        };

        Object.values(mTables).forEach(cfg => {

            const oTable = sap.ui.getCore().byId(cfg.id);
            if (!oTable || !oTable.getColumns) return;

            oTable.setWidth("100%");

            // ⭐ REQUIRED for GRID table (earmark)
            if (cfg.forceFixed) {
                const dom = oTable.getDomRef();
                if (dom) dom.style.tableLayout = "fixed";
            }

            const aBizCols = oTable.getColumns().filter(c =>
                c.getId().includes("::C::")
            );

            aBizCols.forEach((c, i) => {
                if (cfg.widths[i]) {
                    c.setWidth(cfg.widths[i]); // only this for grid
                }
            });
        });
    }
    function sortEarmarkTable() {

        const oTable = sap.ui.getCore().byId(
            "loanoffercreation::ContractObjectPage--fe::table::contractToEarmark::LineItem::_-innerTable"
        );

        if (!oTable) return;

        const oBinding = oTable.getBinding("rows");
        if (!oBinding) return;

        oBinding.sort([
            new sap.ui.model.Sorter("documentNumber", false) // false = ASC
        ]);
    }


    return ControllerExtension.extend("loanoffercreation.ext.controller.Contractobj", {



        /* ===================================================== */

        /* FE lifecycle hooks                                   */

        /* ===================================================== */



        override: {



            onInit: function () {

                this._setupDateObserver();

            },



            onAfterRendering: function () {

                // this._attachAnchorBarClick();

                // this._formatDisplayDates();

            },



            routing: {

                // onAfterBinding: function () {

                //     this._formatEditDates();

                //     this._formatDisplayDates();

                // }



                onAfterBinding: function () {

                    this._formatEditDates();

                    this._formatDisplayDates();


                    debugger;
                    setTimeout(setFixedFormLayout, 600);
                    setTimeout(setWidth, 500);
                    setTimeout(() => {
                        sortEarmarkTable();
                    }, 300);





                    const aTableIds = [

                        "loanoffercreation::ContractObjectPage--fe::table::contractToPartner::LineItem::Partners-innerTable",

                        "loanoffercreation::ContractObjectPage--fe::table::contractToCondition::LineItem::ConditionItems-innerTable",

                        "loanoffercreation::ContractObjectPage--fe::table::contractToDisbursement::LineItem::Disbursements-innerTable",
                        // "loanoffercreation::ContractObjectPage--fe::table::contractToEarmark::LineItem::Earmark"
                    ];



                    function formatDateColumn() {



                        aTableIds.forEach(function (sTableId) {



                            const oInnerTable = sap.ui.core.Element.getElementById(sTableId);



                            console.log(

                                sTableId,

                                oInnerTable ? oInnerTable.getMetadata().getName() : "Table not found"

                            );



                            if (!oInnerTable) {

                                setTimeout(formatDateColumn, 500);

                                return;

                            }



                            if (!oInnerTable._dateFormattingAttached) {

                                oInnerTable.attachUpdateFinished(function () {

                                    updateRows(oInnerTable);

                                });

                                oInnerTable._dateFormattingAttached = true;

                            }



                            updateRows(oInnerTable);

                        });

                    }



                    function updateRows(oInnerTable) {

                        debugger;



                        const aItems = oInnerTable.getItems();

                        if (!aItems || aItems.length === 0) return;



                        const sTableId = oInnerTable.getId();



                        aItems.forEach(function (oItem) {

                            const aCells = oItem.getCells();



                            /* ========= Partner Table ========= */

                            if (sTableId.includes("contractToPartner")) {

                                formatDateCell(aCells[5], "startRel");

                                formatDateCell(aCells[6], "endRel");

                            }



                            /* ========= Condition Table ========= */

                            if (sTableId.includes("contractToCondition")) {

                                formatDateCell(aCells[1], "effectiveFrom");

                                formatDateCell(aCells[6], "dueDate");

                                formatDateCell(aCells[7], "calculationDate");

                            }



                            /* ========= Disbursement Table ========= */

                            if (sTableId.includes("contractToDisbursement")) {

                                formatDateCell(aCells[2], "paymentDate");

                                formatDateCell(aCells[3], "effectiveDate");

                            }

                        });

                    }





                    function formatDateCell(oCell, sPath) {

                        if (!oCell) return;



                        // Edit mode (DatePicker)

                        const oDatePicker =

                            oCell?.mAggregations?.content?.mAggregations?.contentEdit?.[0];



                        if (oDatePicker && oDatePicker.setDisplayFormat) {

                            oDatePicker.unbindProperty("value");

                            oDatePicker.bindProperty("dateValue", { path: sPath });

                            oDatePicker.setDisplayFormat("MM/dd/yyyy");

                            oDatePicker.setValueFormat("yyyy/MM/dd");

                        }



                        // Display mode (Text)

                        const oTextDisplay =

                            oCell?.mAggregations?.content?.mAggregations?.contentDisplay;



                        if (oTextDisplay && oTextDisplay.setText) {

                            let sDate = oTextDisplay.getText();



                            if (!sDate) {

                                const oBinding = oTextDisplay.getBinding("text");

                                if (oBinding) {

                                    sDate = oBinding.getValue();

                                }

                            }



                            if (sDate) {

                                const oDate = new Date(sDate);

                                if (!isNaN(oDate.getTime())) {

                                    const dd = String(oDate.getDate()).padStart(2, "0");

                                    const mm = String(oDate.getMonth() + 1).padStart(2, "0");

                                    const yyyy = oDate.getFullYear();

                                    oTextDisplay.setText(`${mm}/${dd}/${yyyy}`);

                                } else {

                                    oTextDisplay.setText("");

                                }

                            } else {

                                oTextDisplay.setText("");

                            }

                        }

                    }



                    // 🔥 Start formatting

                    formatDateColumn();

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



        // _attachAnchorBarClick: function () {

        //     const sId = "loanoffercreation::ContractObjectPage--fe::ObjectPage-anchBar";

        //     const oAnchorBar = document.getElementById(sId);

        //     if (!oAnchorBar) return;



        //     if (oAnchorBar.dataset.feClickAttached === "true") return;

        //     oAnchorBar.dataset.feClickAttached = "true";



        //     oAnchorBar.addEventListener("click", () => {

        //         setTimeout(() => {

        //             sortTable(
        //                 "loanoffercreation::ContractObjectPage--fe::table::contractToEarmark::LineItem::_-innerTable",
        //                 0   // 👈 column index to sort by (change if needed)
        //             );

        //         }, 600);

        //         console.log("Anchor Pressed");

        //     });

        // },



    });

});