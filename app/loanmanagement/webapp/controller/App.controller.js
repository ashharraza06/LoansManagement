sap.ui.define([
  "sap/ui/core/mvc/Controller"
], (BaseController) => {
  "use strict";

  return BaseController.extend("loanmanagement.controller.App", {
    onInit() {
      var oloanCreationContainer = this.getOwnerComponent().createComponent({
        usage: "screen1", async: true, manifest: true
      });
      oloanCreationContainer.then(
        function (oloanCreation) {
          debugger
          this.byId("screen1").setComponent(oloanCreation);
          this._loanCreationContainer = oloanCreation;
        }.bind(this)
      );

    }
  });
});