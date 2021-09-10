//
//  AchievementCellView.swift
//  Sports Tracker
//
//  Created by Lucansky Michal on 9/9/21.
//

import SwiftUI
import MapKit

struct AchievementCellView: View {
    let achievement: SportActivity

    var body: some View {
        HStack {
            Rectangle()
                .fill(achievement.storeType.storeTypeColor)
                .frame(width: 16, height: .infinity)
            Label("", systemImage: achievement.storeType.iconName)
                .padding()
                .foregroundColor(Color.primary)
            Spacer()
            Text(achievement.name)
                .bold()
                .font(.headline)
                .padding()
            NavigationLink(destination: ActivityDetailView(coordinateRegion: makeActivityRegion(), achievement: achievement)) {}
        }
    }

    func makeActivityRegion() -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: achievement.location,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
}

struct AchievementCellView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementCellView(achievement: SportActivity.demo)
    }
}
