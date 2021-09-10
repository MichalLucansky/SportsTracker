//
//  SportsViewModel.swift
//  Sports Tracker
//
//  Created by Lucansky Michal on 9/9/21.
//

import Foundation
import MapKit

final class SportsViewModel: ObservableObject {
    @Published var saveType: StoreType = .local
    @Published var activityName = ""
    @Published var activityDurationHours = ""
    @Published var activityDurationMinutes = ""
    @Published var centerCoordinate = CLLocationCoordinate2D()
    
    var activity: SportActivity {
        return SportActivity(
            name: activityName,
            location: centerCoordinate,
            durationHours: activityDurationHours,
            durationMinutes: activityDurationMinutes,
            storeType: saveType
        )
    }
}
