//
//  Sport.swift
//  Sports Tracker
//
//  Created by Lucansky Michal on 9/9/21.
//

import Foundation
import MapKit
import RealmSwift
import SwiftUI

enum StoreType: String {
    case cloud
    case local

    var storeTypes: [StoreType] {
        return [.cloud, .local]
    }

    var iconName: String {
        switch self {
        case .cloud:
            return "externaldrive.badge.icloud"
        case .local:
            return "externaldrive"
        }
    }

    var storeTypeColor: Color {
        switch self {
        case .cloud:
            return .primary
        case .local:
            return .secondary
        }
    }
}

struct SportActivity: Identifiable {
    let id = UUID()
    let name: String
    let location: CLLocationCoordinate2D
    let durationHours: String
    let durationMinutes: String
    let storeType: StoreType

    var hasValidLocation: Bool {
        return location.latitude != 0 && location.longitude != 0
    }

    static var demo: SportActivity {
        return SportActivity(
            name: "Hockey",
            location: CLLocationCoordinate2D(),
            durationHours: "0",
            durationMinutes: "0",
            storeType: .local
        )
    }
}

extension SportActivity {
    func makeRealmObject() -> Activity {
        let activity = Activity()
        activity.id = id
        activity.name = name
        activity.latitude = location.latitude
        activity.longitude = location.longitude
        activity.durationHours = durationHours
        activity.durationMinutes = durationMinutes
        activity.storeType = storeType.rawValue
        return activity
    }
}
