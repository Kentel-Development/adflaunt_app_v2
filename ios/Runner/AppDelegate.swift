import UIKit
import Flutter
import GoogleMaps
import FirebaseCore // Add this line

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    FirebaseApp.configure() // Add this line
    GeneratedPluginRegistrant.register(with: self)
    GMSServices.provideAPIKey("AIzaSyDk8P9O2biGq5vil3e6R1Cwfk0QYUyirks")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
