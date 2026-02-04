//
//  Habit.swift
//  HabitTracker
//
//  Created by Manideep Gattamaneni on 2/1/26.
//

import Foundation

struct ActivityItem: Identifiable, Codable, Equatable {
    var id = UUID()
    let name: String
    var description: String
    var completedCount: Int = 0
}
