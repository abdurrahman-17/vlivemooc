import UIKit
import Flutter



@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
    var player: PlayerViewController?
    var playContent: PlayContent?
    override func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
            let mediaChannel = FlutterMethodChannel(name: "com.mobiotics.media", binaryMessenger: controller.binaryMessenger)
            let playerChannel = FlutterMethodChannel(name: "com.mobiotics.androidplayer", binaryMessenger: controller.binaryMessenger)
            mediaChannel.setMethodCallHandler({
                (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                // This method is invoked on the UI thread.
                guard call.method == "openPlayer" else {
                    result(FlutterMethodNotImplemented)
                    return
                }
                print(call.arguments, "TESTDATA")
                if let dict = call.arguments as? [String: Any] {
                    do {
                        let jsonData = try JSONSerialization.data(withJSONObject: dict, options: .prettyPrinted)
                        let content = try JSONDecoder().decode(PlayContent.self, from: jsonData)
                        self.playContent(content, flutterController: controller, returnClosePressed: nil) { playerData in
                            playerChannel.invokeMethod("updateWatchedPercentage", arguments: playerData)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                } else {
                    print("call.arguments not Dict String: Any")
                }
            })
            GeneratedPluginRegistrant.register(with: self)
            return super.application(application, didFinishLaunchingWithOptions: launchOptions)
        }
    func playContent(_ playContent: PlayContent?,
                     flutterController: FlutterViewController,
                     returnClosePressed: (() -> Void)?,
                     returnContentProgress: ((Any?) -> Void)?) {
        guard player == nil else {
            debugPrint("player is alrady presented")
            return
        }
        self.playContent = playContent
        player = PlayerViewController()
        player?.flutterDelegate = self
        player?.returnClosePressed = returnClosePressed
        player?.returnContentProgress = returnContentProgress
        player?.defaultSubtitleLanguageCode = playContent?.defaultSubtitleLanguageCode
        player?.persistedSettings = playContent?.fetchPersistenceSettings()
        player?.userEmailAndIP = playContent?.playerSecurity
        player?.modalPresentationStyle = .fullScreen
        if let content = playContent?.content, let streamDetails = playContent?.streamDetails {
            self.player?.playVideo(content,
                                   streamDetails: streamDetails,
                                   startDuration: playContent?.startDuration,
                                   playLeadDuration: playContent?.clearLeadDuration)
        } else if let content = playContent?.content, let trailer = playContent?.selectedTrailer {
            
            self.player?.playTrailer(trailer, trailerContent: content)
        }
        flutterController.present(player!, animated: true, completion: nil)
    }
}
extension AppDelegate: PlayerViewControllerFlutterDelegate {
    func didPlaylistPressed() {
        
    }
    func didChromeCastPressed(content: Content?) {
        
    }
    func fetchFairplayCertificate() -> Data? {
        guard let certURL = Bundle.main.url(forResource: "fairplay", withExtension: "cer") else { return nil }
        return try? Data(contentsOf: certURL)
    }
    func fetchWidevineLicense(with data: Data!, contentId: String!, completionBlock: ((Data?, Error?) -> Void)!) {
        
    }
    func fetchFairplayLicense(with data: Data!, contentId: String!) -> Data? {
        var parameters = [String: Any]()
        parameters["payload"] = data.base64EncodedString()
        parameters["drmscheme"] = "FAIRPLAY"
        parameters["contentid"] = contentId
        parameters["providerid"] = playContent?.providerId
        parameters["timestamp"] = Date().timestamp
        parameters["customdata"] = ["packageid" : playContent?.streamDetails?.packageid ?? "",
                                    "drmtoken": self.fetchToken()]
        NSLog("playback-log: drm token received \(parameters)")
        guard let url = URL(string: playContent?.licenseURL ?? "") else { return nil }
        do {
            let josnBody = try JSONSerialization.data(withJSONObject: parameters, options: JSONSerialization.WritingOptions.prettyPrinted)
            let licenseRequest = NSMutableURLRequest(url: url, cachePolicy: NSURLRequest.CachePolicy.reloadIgnoringCacheData, timeoutInterval: 10)
            licenseRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            licenseRequest.httpMethod = "POST"
            licenseRequest.httpBody = josnBody
            let session = URLSession.shared
            if let licenseData = session.requestSynchronousData(licenseRequest as URLRequest) {
                NSLog("playback-log: license received")
                do {
                    let licenseResponce = try JSONSerialization.jsonObject(with: licenseData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                    if let license = licenseResponce?["body"] as? String {
                        let decodedData = Data(base64Encoded: license, options: Data.Base64DecodingOptions())
                        return decodedData
                    } else {
                        return nil
                    }
                } catch {
                    debugPrint("ERror : \(error)")
                }
            }
        } catch {
            debugPrint("ERror : \(error)")
        }
        return nil
    }
    private func fetchToken() -> String? {
        var parameters = [String: Any]()
        parameters["contentid"] = playContent?.content?.objectid ?? ""
        parameters["packageid"] = playContent?.streamDetails?.packageid ?? ""
        parameters["drmscheme"] = "FAIRPLAY"
        parameters["availabilityid"] = playContent?.availabilityId
        parameters["offline"] = "NO"
        guard let url = URL(string: playContent?.drmTokenURL ?? "") else { return nil}
        var request = URLRequest(url: url)
        var queryItems = [String]()
        for (paramName, paramValue) in parameters {
            queryItems.append("\(paramName)="+("\(paramValue)".addingPercentEncoding(withAllowedCharacters: .alphanumerics) ?? ""))
        }
        request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalAndRemoteCacheData, timeoutInterval: 30)
        request.httpMethod = "POST"
        let params = queryItems.joined(separator: "&")
        request.httpBody = params.data(using: .utf8)
        request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.allHTTPHeaderFields = ["X-SESSION" : (playContent?.sessionToken ?? "")]
        if let responseData = URLSession.shared.requestSynchronousData(request) {
            do {
                let tokenDict = try JSONSerialization.jsonObject(with: responseData, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any]
                if let token = tokenDict?["success"] as? String {
                    return token
                } else if let errorCode = tokenDict?["errorcode"] as? Int, errorCode == 6066 || errorCode == 6055 {
                    
                } else if let message = tokenDict?["message"] {
                    debugPrint("ERR :\(message)")
                }
            } catch {
                debugPrint("ERror : \(error)")
            }
        }
        return nil
    }
    func callAutoLogin() -> Bool {
        let semaphore: DispatchSemaphore = DispatchSemaphore(value: 0)
        var responseData: Data?
        /*
         Here we have to call the session renewal to flutter
         */
        _ = semaphore.wait(timeout: DispatchTime.distantFuture)
        return true
    }
    func playerDidFailed(_ error: Error?) {
        // if error code == 9003 clear lead is over...
    }
}

