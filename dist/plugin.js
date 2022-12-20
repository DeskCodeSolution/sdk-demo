var capacitorsdkdemo = (function (exports, core) {
    'use strict';

    const sdkdemo = core.registerPlugin('sdkdemo', {
        web: () => Promise.resolve().then(function () { return web; }).then(m => new m.sdkdemoWeb()),
    });

    class sdkdemoWeb extends core.WebPlugin {
        async echo(options) {
            console.log('ECHO', options);
            return options;
        }
        async joinChannel(options) {
            console.log('ECHO', options);
            return options;
        }
        async leaveChannel(options) {
            console.log('ECHO', options);
            return options;
        }
    }

    var web = /*#__PURE__*/Object.freeze({
        __proto__: null,
        sdkdemoWeb: sdkdemoWeb
    });

    exports.sdkdemo = sdkdemo;

    Object.defineProperty(exports, '__esModule', { value: true });

    return exports;

})({}, capacitorExports);
//# sourceMappingURL=plugin.js.map
