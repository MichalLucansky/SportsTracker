//
//  PersistanceManager.swift
//  Sports Tracker
//
//  Created by Lucansky Michal on 9/10/21.
//

import Foundation
import RealmSwift
import Realm
import Firebase
import MapKit

typealias firestoreClosureType = (Result<[SportActivity], Error>) -> Void

final class PersistanceManager {
    private let realm = try? Realm()
    private let firestore = Firestore.firestore()
    // MARK: Realm
    func saveToReal(realmObject: Activity) {
        try? realm?.write({
            realm?.add(realmObject)
        })
    }

    func getActivitiesFromRealm() -> Results<Activity>? {
        return realm?.objects(Activity.self)
    }
    // Mark: Firestore
    func saveToFirestore(activity: Activity) {
        firestore.collection("achievement").addDocument(data:
                                                            [
                                                                "name": activity.name,
                                                                "latitude": activity.latitude,
                                                                "longitute": activity.longitude,
                                                                "durationHours": activity.durationHours,
                                                                "durationMinutes": activity.durationMinutes,
                                                                "storeType": activity.storeType
                                                            ]
        ) { error in
            if let error = error {
                print("Error adding document: \(error)")
            }
        }
    }

    func getActivitiesFromFirestore(closure: @escaping firestoreClosureType) {
        firestore.collection("achievement").getDocuments() { (querySnapshot, error) in
            if let error = error {
                closure(.failure(error))
            } else {
                var result = [SportActivity]()
                for document in querySnapshot!.documents {
                    let data = document.data()
                    let sport = SportActivity(
                        name: data["name"] as? String ?? "",
                        location: CLLocationCoordinate2D(
                            latitude: data["latitude"] as? CLLocationDegrees ?? 0,
                            longitude: data["longitute"] as? CLLocationDegrees ?? 0
                        ),
                        durationHours: data["durationHours"] as? String ?? "",
                        durationMinutes: data["durationMinutes"] as? String ?? "",
                        storeType: StoreType(rawValue: data["storeType"] as? String ?? "")!
                    )
                    result.append(sport)
                }
                closure(.success(result))
            }
        }
    }
}

