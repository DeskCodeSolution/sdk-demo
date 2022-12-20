import { registerPlugin } from '@capacitor/core';

import type { sdkdemoPlugin } from './definitions';

const sdkdemo = registerPlugin<sdkdemoPlugin>('sdkdemo', {
  web: () => import('./web').then(m => new m.sdkdemoWeb()),
});

export * from './definitions';
export { sdkdemo };
