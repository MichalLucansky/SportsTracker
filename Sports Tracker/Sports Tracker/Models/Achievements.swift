//
//  Achievemts.swift
//  Sports Tracker
//
//  Created by Lucansky Michal on 9/9/21.
//

import Foundation
import SwiftUI

final class Achievements: ObservableObject {
    private let persistanceManage = PersistanceManager()
    @Published var databaseStored = [SportActivity]()
    @Published var cloudStored = [SportActivity]()
    @Published var errorMessage = ""
    var isEmpty: Bool {
        return databaseStored.isEmpty && cloudStored.isEmpty
    }

    init() {
        getAchievements()
    }

    func addSport(activity: SportActivity) {
        switch activity.storeType {
        case .local:
            databaseStored.append(activity)
        case .cloud:
            cloudStored.append(activity)
        }
    }

    func saveToDatabase(type: StoreType, activity: SportActivity) {
        switch type {
        case .cloud:
            saveInCloud(activity: activity)
        case .local:
            saveLocaly(activity: activity)
        }
    }
}

private extension Achievements {
    func getAchievements() {
        loadDataFromCloud { [weak self] activities in
            guard let activities = activities else { return }
            self?.cloudStored = activities
        }
        databaseStored = loadDataFromDataBase()
    }
    
    func loadDataFromDataBase() -> [SportActivity] {
        var result = [SportActivity]()
        guard let activities = persistanceManage.getActivitiesFromRealm() else { return result }
        for activity in activities {
            result.append(activity.makeSportActivity())
        }
        return result
    }

    func loadDataFromCloud(closure: @escaping ([SportActivity]?) -> Void) {
        persistanceManage.getActivitiesFromFirestore() { [weak self] result in
            switch result {
            case .success(let activities):
                closure(activities)
            case .failure(let error):
                self?.errorMessage = error.localizedDescription
            }
        }
    }

    func saveInCloud(activity: SportActivity) {
        persistanceManage.saveToFirestore(activity: activity.makeRealmObject())
    }

    func saveLocaly(activity: SportActivity) {
        persistanceManage.saveToReal(realmObject: activity.makeRealmObject())
    }
}
