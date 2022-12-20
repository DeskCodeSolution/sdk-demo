import { WebPlugin } from '@capacitor/core';
export class sdkdemoWeb extends WebPlugin {
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
//# sourceMappingURL=web.js.map