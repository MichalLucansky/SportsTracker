//
//  AchievementCellView.swift
//  Sports Tracker
//
//  Created by Lucansky Michal on 9/9/21.
//

import SwiftUI
import MapKit

struct AchievementCellView: View {
    let achivement: SportActivity

    var body: some View {
        HStack {
            Rectangle()
                .fill(achivement.storeType.storeTypeColor)
                .frame(width: 16, height: .infinity)
            Label("", systemImage: achivement.storeType.iconName)
                .padding()
                .foregroundColor(Color.primary)
            Spacer()
            Text(achivement.name)
                .bold()
                .font(.headline)
                .padding()
            NavigationLink(destination: ActivityDetailView(coordinateRegion: makeActivityRegion(), achivement: achivement)) {}
        }
    }

    func makeActivityRegion() -> MKCoordinateRegion {
        return MKCoordinateRegion(
            center: achivement.location,
            span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2))
    }
}

struct AchievementCellView_Previews: PreviewProvider {
    static var previews: some View {
        AchievementCellView(achivement: SportActivity.demo)
    }
}
