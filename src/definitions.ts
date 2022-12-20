export interface sdkdemoPlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
  joinChannel(options: { value: string }): Promise<{ value: string }>
  leaveChannel(options: { value: string }): Promise<{ value: string }>
}
