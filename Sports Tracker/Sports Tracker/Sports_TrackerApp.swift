//
//  Sports_TrackerApp.swift
//  Sports Tracker
//
//  Created by Lucansky Michal on 9/8/21.
//

import SwiftUI

@main
struct Sports_TrackerApp: App {
    @UIApplicationDelegateAdaptor private var appDelegate: AppDelegate
    @StateObject var achievements = Achievements()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(achievements)
        }
    }
}
