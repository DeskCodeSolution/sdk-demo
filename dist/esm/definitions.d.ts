export interface sdkdemoPlugin {
    echo(options: {
        value: string;
    }): Promise<{
        value: string;
    }>;
}
