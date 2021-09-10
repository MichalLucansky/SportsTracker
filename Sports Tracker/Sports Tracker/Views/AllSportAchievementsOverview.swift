//
//  AllSportAchievementsOverview.swift
//  Sports Tracker
//
//  Created by Lucansky Michal on 9/9/21.
//

import SwiftUI

struct AllSportAchievementsOverview: View {
    @EnvironmentObject var achievements: Achievements
    @State private var filteredBy = 0

    var body: some View {
        NavigationView {
            VStack {
                if !achievements.errorMessage.isEmpty {
                    Text(achievements.errorMessage)
                } else if achievements.isEmpty {
                    Text("No achievements to show.")
                } else {
                    Picker("Filtered by: ", selection: $filteredBy) {
                        Text("All").tag(0)
                        Text("Cloud").tag(1)
                        Text("Local").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding([.leading, .trailing])

                    List {
                        if filteredBy == 0 || filteredBy == 2 {
                            Section {
                                if achievements.databaseStored.isEmpty {
                                    Text("No Localy stored achievements.")
                                } else {
                                    ForEach(achievements.databaseStored) { sport in
                                        AchievementCellView(achievement: sport)
                                    }
                                }
                            }
                        }

                        if filteredBy == 0 || filteredBy == 1 {
                            Section {
                                if achievements.cloudStored.isEmpty {
                                    Text("No Cloud stored achievements.")
                                } else {
                                    ForEach(achievements.cloudStored) { sport in
                                        AchievementCellView(achievement: sport)
                                    }
                                }
                            }
                        }
                    }
                    .listStyle(GroupedListStyle())
                    .padding([.leading, .trailing])
                }
            }
            .navigationTitle("Achievements")
        }
    }
}

struct AllSportAchievementsOverview_Previews: PreviewProvider {
    static var previews: some View {
        AllSportAchievementsOverview()
            .environmentObject(Achievements())
    }
}
