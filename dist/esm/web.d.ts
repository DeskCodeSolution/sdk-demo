import { WebPlugin } from '@capacitor/core';
import type { sdkdemoPlugin } from './definitions';
export declare class sdkdemoWeb extends WebPlugin implements sdkdemoPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
}
