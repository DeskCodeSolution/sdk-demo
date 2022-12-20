'use strict';

Object.defineProperty(exports, '__esModule', { value: true });

var core = require('@capacitor/core');

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
//# sourceMappingURL=plugin.cjs.js.map
