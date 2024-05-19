//
//  AppDelegate.swift
//  ExpenseTracker
//
//  Created by Kartikay Singh on 18/05/24.
//

import Foundation
import Firebase
import FirebaseFirestore

#if os(macOS)
import Cocoa

class AppDelegate: NSObject, NSApplicationDelegate {
    func applicationWillFinishLaunching(_ notification: Notification) {
        setUpFirebase()
    }
}
#else
import UIKit
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        setUpFirebase()
        return true
    }
}

#endif



fileprivate func isPreviewRunTime() -> Bool {
    ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}


fileprivate func setUpFirebase() {
    FirebaseApp.configure()
    if isPreviewRunTime() {
        let settings = FirestoreSettings()
        settings.host = "localhost:8080"
        settings.isPersistenceEnabled = false
        settings.isSSLEnabled = false
        
        Firestore.firestore().settings = settings
    }
}
