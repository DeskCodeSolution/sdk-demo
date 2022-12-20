import Foundation
import Capacitor
import UIKit
import AVFoundation
import AgoraRtcKit

/**
 * Please read the Capacitor iOS Plugin Development Guide
 * here: https://capacitorjs.com/docs/plugins/ios
 */
@objc(sdkdemoPlugin)
public class sdkdemoPlugin: CAPPlugin {
    private let implementation = sdkdemo()

     // The main entry point for Video SDK
    var agoraEngine: AgoraRtcEngineKit!
    
    // By default, set the current user role to broadcaster to both send and receive streams.
    var userRole: AgoraClientRole = .broadcaster
    
    // Update with the App ID of your project generated on Agora Console.
    let appID = "6efdd253f1c74743bd343fc97c136d6c"
    
    // Update with the temporary token generated in Agora Console.
    var token = "007eJxTYBCZYrE4e+KurrWvknadk6j81W4SuNx1Sc3jd+ZMynt/B3xTYDBLTUtJMTI1TjNMNjcxNzFOSjE2MU5LtjRPNjQ2SzFLbv45O7khkJEhbU0xMyMDBIL4vAwlqcUl8ckZiXl5qTmGDAwAI1AlLA=="
    
    // Update with the channel name you used to generate the token in Agora Console.
    var channelName = "RemoteDesk"
    
    // The video feed for the local user is displayed here
    var localView: UIView!
    // The video feed for the remote user is displayed here
    var remoteView: UIView!
    
    var joined: Bool = false

    @objc func echo(_ call: CAPPluginCall) {
        let value = call.getString("value") ?? ""
        call.resolve([
            "value": implementation.echo(value)
        ])
    }

     @objc func joinChannel(_ call: CAPPluginCall) {
        initializeAgoraEngine()
        initViews()
        joinChannel()
        call.resolve([
            "value": implementation.echo("Join channel value")
        ])
    }
    
    @objc func leaveChannel(_ call: CAPPluginCall) {
        leaveChannel()
         call.resolve([
            "value": implementation.echo("leaveChannel value")
        ])
    }
    
    //MARK: Sub Functions
    func initViews() {
        remoteView.frame = UIScreen.main.bounds
        localView.frame = UIScreen.main.bounds
    }
    
    func checkForPermissions() -> Bool {
        var hasPermissions = false
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: hasPermissions = true
        default: hasPermissions = requestCameraAccess()
        }
        // Break out, because camera permissions have been denied or restricted.
        if !hasPermissions { return false }
        switch AVCaptureDevice.authorizationStatus(for: .audio) {
        case .authorized: hasPermissions = true
        default: hasPermissions = requestAudioAccess()
        }
        return hasPermissions
    }
    
    func requestCameraAccess() -> Bool {
        var hasCameraPermission = false
        let semaphore = DispatchSemaphore(value: 0)
        AVCaptureDevice.requestAccess(for: .video, completionHandler: { granted in
            hasCameraPermission = granted
            semaphore.signal()
        })
        semaphore.wait()
        return hasCameraPermission
    }
    
    func requestAudioAccess() -> Bool {
        var hasAudioPermission = false
        let semaphore = DispatchSemaphore(value: 0)
        AVCaptureDevice.requestAccess(for: .audio, completionHandler: { granted in
            hasAudioPermission = granted
            semaphore.signal()
        })
        semaphore.wait()
        return hasAudioPermission
    }
    
    func initializeAgoraEngine() {
        let config = AgoraRtcEngineConfig()
        // Pass in your App ID here.
        config.appId = appID
        // Use AgoraRtcEngineDelegate for the following delegate parameter.
        agoraEngine = AgoraRtcEngineKit.sharedEngine(with: config, delegate: self)
    }
    
    func joinChannel() {
        if !self.checkForPermissions() {
//            showMessage(title: "Error", text: "Permissions were not granted")
            return
        }

        let option = AgoraRtcChannelMediaOptions()

        // Set the client role option as broadcaster or audience.
        if self.userRole == .broadcaster {
            option.clientRoleType = .broadcaster
            setupLocalVideo()
        } else {
            option.clientRoleType = .audience
        }

        // For a video call scenario, set the channel profile as communication.
        option.channelProfile = .communication

        // Join the channel with a temp token. Pass in your token and channel name here
        let result = agoraEngine.joinChannel(
            byToken: token, channelId: channelName, uid: 0, mediaOptions: option,
            joinSuccess: { (channel, uid, elapsed) in }
        )
            // Check if joining the channel was successful and set joined Bool accordingly
        if (result == 0) {
            joined = true
//            showMessage(title: "Success", text: "Successfully joined the channel as \(self.userRole)")
        }
    }
    
    func setupLocalVideo() {
        // Enable the video module
        agoraEngine.enableVideo()
        // Start the local video preview
        agoraEngine.startPreview()
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = 0
        videoCanvas.renderMode = .hidden
        videoCanvas.view = localView
        // Set the local video view
        agoraEngine.setupLocalVideo(videoCanvas)
    }
    
    func leaveChannel() {
        agoraEngine.stopPreview()
        let result = agoraEngine.leaveChannel(nil)
        // Check if leaving the channel was successful and set joined Bool accordingly
        if (result == 0) { joined = false }
    }
}

extension sdkdemoPlugin: AgoraRtcEngineDelegate {
    public func rtcEngine(_ engine: AgoraRtcEngineKit, didJoinedOfUid uid: UInt, elapsed: Int) {
        let videoCanvas = AgoraRtcVideoCanvas()
        videoCanvas.uid = uid
        videoCanvas.renderMode = .hidden
        videoCanvas.view = remoteView
        agoraEngine.setupRemoteVideo(videoCanvas)
    }
}
