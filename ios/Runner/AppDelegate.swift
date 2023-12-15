import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

      let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
      let osChannel = FlutterMethodChannel(name: "com.rasityilmaz.osversion",
                                                binaryMessenger: controller.binaryMessenger)
      osChannel.setMethodCallHandler({
          [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
          // This method is invoked on the UI thread.
          guard call.method == "getOsVersion" else {
              result(FlutterMethodNotImplemented)
              return
          }
          self?.receiveOsVersion(result: result)
      })

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  private func receiveOsVersion(result: FlutterResult) {
    let systemVersion = UIDevice.current.systemVersion
    
    if systemVersion == systemVersion{
        
        result(systemVersion)
    } else {
        result("0.0.0")
    }
}

}

