//
//  ContentView.swift
//  Sports Tracker
//
//  Created by Lucansky Michal on 9/8/21.
//

import SwiftUI

struct MainView: View {
    @EnvironmentObject var achievements: Achievements

    var body: some View {
        TabView {
            EnterSportAchievementView()
                .tabItem {
                    Label("Sport", systemImage: "square.and.pencil" )
                }
            AllSportAchievementsOverview()
                .tabItem {
                    Label("Achievements ", systemImage: "heart.text.square" )
                }
        }   
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(Achievements())
    }
}
