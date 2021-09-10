//
//  ActivityDetailView.swift
//  Sports Tracker
//
//  Created by Lucansky Michal on 9/10/21.
//

import SwiftUI
import MapKit

struct ActivityDetailView: View {
    @State var coordinateRegion: MKCoordinateRegion
    let achievement: SportActivity
    var body: some View {
            VStack {
                if achievement.hasValidLocation {
                    ZStack {
                        Map(coordinateRegion: $coordinateRegion)
                        Circle()
                            .fill(Color.blue)
                            .opacity(0.3)
                            .frame(width: 32, height: 32)
                    }
                }
                Text("Activity duration \(achievement.durationHours) h \(achievement.durationMinutes) min")
                    .font(.body)
                    .padding()
                Label("", systemImage: achievement.storeType.iconName)
                    .padding()
                    .foregroundColor(Color.primary)
                    .font(.title)
            }
            .navigationTitle(Text(achievement.name))
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct ActivityDetailView_Previews: PreviewProvider {
    static var previews: some View {
        ActivityDetailView(
            coordinateRegion: MKCoordinateRegion(
                center: CLLocationCoordinate2D(
                    latitude: 56.948889,
                    longitude: 24.106389
                ),
                span: MKCoordinateSpan(
                    latitudeDelta: 0.2,
                    longitudeDelta: 0.2
                )
            ),
            achievement: SportActivity.demo
        )
    }
}
