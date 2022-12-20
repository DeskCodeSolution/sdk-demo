import { WebPlugin } from '@capacitor/core';

import type { sdkdemoPlugin } from './definitions';

export class sdkdemoWeb extends WebPlugin implements sdkdemoPlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
  async joinChannel(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options)
    return options
  }
  async leaveChannel(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options)
    return options
  }
}
