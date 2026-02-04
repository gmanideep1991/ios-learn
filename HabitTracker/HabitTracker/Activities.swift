//
//  Activities.swift
//  HabitTracker
//
//  Created by Manideep Gattamaneni on 2/1/26.
//

import Foundation

@Observable
class Activities {
    var items = [ActivityItem]() {
        didSet {
            save()
        }
    }
    init(){
        if let savedActivities = UserDefaults.standard.data(forKey: "activities"){
            if let decodedActivities = try? JSONDecoder().decode(
                [ActivityItem].self,
                from: savedActivities
            ) {
                items = decodedActivities
                return
            }
        }
        items = []
    }
    func save() {
            if let encoded = try? JSONEncoder().encode(items) {
                UserDefaults.standard.set(encoded, forKey: "activities")
            }
        }
}
