import UIKit
import Flutter
import Firebase
import FirebaseMessaging
import GoogleMaps

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure()
    GMSServices.provideAPIKey("AIzaSyATma2tn2hS0AviulYrtjUDIgsJ1dFY7No")
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  override func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: data) {
    Messaging.messaging().apnsToken = deviceToken
    print("Token: \(deviceToken)")
    super.application(application, didRegisterForRemoteNotificationsWithDeviceToken: deviceToken)
  }
}
