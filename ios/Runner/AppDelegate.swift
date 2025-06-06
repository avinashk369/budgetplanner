import UIKit
import Flutter
import google_mobile_ads

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
    }
    GeneratedPluginRegistrant.register(with: self)
    // TODO: Register ListTileNativeAdFactory
        // let listTileFactory = ListTileNativeAdFactory()
        // FLTGoogleMobileAdsPlugin.registerNativeAdFactory(
        //     self, factoryId: "listTile", nativeAdFactory: listTileFactory)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
