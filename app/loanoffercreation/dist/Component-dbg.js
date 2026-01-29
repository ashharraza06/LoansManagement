sap.ui.define(
    ["sap/fe/core/AppComponent"],
    function (Component) {
        "use strict";

        return Component.extend("loanoffercreation.Component", {
            metadata: {
                manifest: "json"
            }
            // init: function () {
            //     // 🔑 Force date format to MM/DD/YYYY
            //     sap.ui.getCore().getConfiguration().setFormatLocale("en-US");


            //     // Always call parent init
            //     Component.prototype.init.apply(this, arguments);
            // }
        });
    }
);