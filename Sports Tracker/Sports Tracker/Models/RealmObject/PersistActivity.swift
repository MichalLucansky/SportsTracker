//
//  PersistActivity.swift
//  Sports Tracker
//
//  Created by Lucansky Michal on 9/10/21.
//

import RealmSwift
import MapKit

class Activity: Object {
    @Persisted var id = UUID()
    @Persisted var name: String
    @Persisted var latitude: Double
    @Persisted var longitude: Double
    @Persisted var durationHours: String
    @Persisted var durationMinutes: String
    @Persisted var storeType: String
}

extension Activity {
    func makeSportActivity() -> SportActivity {
        return SportActivity(
            name: name,
            location: CLLocationCoordinate2D(
                latitude: latitude,
                longitude: longitude
            ),
            durationHours: durationHours,
            durationMinutes: durationMinutes,
            storeType: StoreType(rawValue: storeType) ?? .cloud)
    }
}
