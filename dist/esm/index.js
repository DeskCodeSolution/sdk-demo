import { registerPlugin } from '@capacitor/core';
const sdkdemo = registerPlugin('sdkdemo', {
    web: () => import('./web').then(m => new m.sdkdemoWeb()),
});
export * from './definitions';
export { sdkdemo };
//# sourceMappingURL=index.js.map