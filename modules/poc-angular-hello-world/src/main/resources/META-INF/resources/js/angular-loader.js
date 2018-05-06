// Import needed polyfills before application is launched
define(["require", "exports", "reflect-metadata", "zone.js"], function (require, exports) {
    "use strict";
    Object.defineProperty(exports, "__esModule", { value: true });
    // Launch application
    function default_1(rootId) {
        Liferay.Loader.require('poc-angular-hello-world@1.0.0/js/main', function (main) {
            main.default(rootId);
        });
    }
    exports.default = default_1;
});
//# sourceMappingURL=angular-loader.js.map