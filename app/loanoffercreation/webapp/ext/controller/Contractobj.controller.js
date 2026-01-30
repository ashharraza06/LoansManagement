sap.ui.define([

    "sap/ui/core/mvc/ControllerExtension",

    "sap/ui/core/Control",

    "sap/ui/core/format/DateFormat"

], function (ControllerExtension, Control, DateFormat) {

    "use strict";
 
    return ControllerExtension.extend("loanoffercreation.ext.controller.Contractobj", {
 
        // =====================================================

        // FE lifecycle hooks

        // =====================================================
 
        override: {
 
            onInit: function () {

                this._setupDateObserver();

            },
 
            routing: {

                onAfterBinding: function () {

                    this._formatEditDates();

                    this._formatDisplayDates();

                }

            }

        },
 
        // =====================================================

        // EDIT MODE → DatePicker binding fix

        // =====================================================
 
        _formatEditDates: function () {
 
            const oView = this.base.getView();

            if (!oView) return;
 
            this._walkControls(oView, oControl => {
 
                if (oControl.isA && oControl.isA("sap.m.DatePicker")) {
 
                    const oBinding = oControl.getBinding("value");

                    if (oBinding) {

                        const sPath = oBinding.getPath();
 
                        oControl.unbindProperty("value");
 
                        oControl.bindProperty("dateValue", {

                            path: sPath

                        });

                    }
 
                    oControl.setDisplayFormat("MM/dd/yyyy");

                    oControl.setValueFormat("yyyy-MM-dd");

                }

            });

        },
 
        // =====================================================

        // DISPLAY MODE → FE text formatter

        // =====================================================
 
        _formatDisplayDates: function () {
 
            const oFormatter = DateFormat.getDateInstance({

                pattern: "MM/dd/yyyy"

            });
 
            document.querySelectorAll("[id$='Field-display'], .sapMText").forEach(el => {
 
                const sText = el.innerText?.trim();

                if (!sText) return;
 
                // Already formatted → skip

                if (/^\d{2}\/\d{2}\/\d{4}$/.test(sText)) return;
 
                // FE default format: "Jan 5, 2025"

                const m = sText.match(/^([A-Za-z]{3}) (\d{1,2}), (\d{4})$/);

                if (!m) return;
 
                const oDate = new Date(`${m[1]} ${m[2]}, ${m[3]}`);

                if (isNaN(oDate)) return;
 
                el.innerText = oFormatter.format(oDate);

            });

        },
 
        // =====================================================

        // FE dynamic rerender observer

        // =====================================================
 
        _setupDateObserver: function () {
 
            const observer = new MutationObserver(() => {

                this._formatDisplayDates();

            });
 
            observer.observe(document.body, {

                childList: true,

                subtree: true

            });

        },
 
        // =====================================================

        // Recursive FE control walker

        // =====================================================
 
        _walkControls: function (oControl, fnCallback) {
 
            fnCallback(oControl);
 
            if (!oControl.getAggregation) return;
 
            const mAggs = oControl.getMetadata().getAllAggregations();
 
            Object.keys(mAggs).forEach(sAgg => {
 
                const oAgg = oControl.getAggregation(sAgg);
 
                if (Array.isArray(oAgg)) {

                    oAgg.forEach(c => this._walkControls(c, fnCallback));

                }

                else if (oAgg instanceof Control) {

                    this._walkControls(oAgg, fnCallback);

                }

            });

        }
 
    });

});

 