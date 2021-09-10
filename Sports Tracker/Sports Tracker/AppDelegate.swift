//
//  AppDelegate.swift
//  Sports Tracker
//
//  Created by Lucansky Michal on 9/8/21.
//

import Foundation
import Firebase

final class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        FirebaseApp.configure()
        return true
    }
}
