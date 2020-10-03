import UIKit
import Flutter
import Toast_Swift

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
      _ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    let controller = window?.rootViewController as! FlutterViewController;
    let toastChannel = FlutterMethodChannel(name: "samples.flutter.dev/toast", binaryMessenger: controller.binaryMessenger)

    toastChannel.setMethodCallHandler{ (call, result) in
                switch call.method {
                  case "toast":
                    self.window?.makeToast("Value Inserted!")
                  case "delete":
                    self.window?.makeToast("All Values Deleted!")
                  default:
                    break
                }
           }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
