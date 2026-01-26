//
//  Mission.swift
//  Moonshot
//
//  Created by Manideep Gattamaneni on 1/25/26.
//

import Foundation

struct Mission: Codable, Identifiable {
    
    struct CrewRole: Codable {
        let name: String
        let role: String
    }
    
    let id: Int
    let launchDate: Date?
    let crew: [CrewRole]
    let description: String
    
    var displayName: String {
        "Apollo \(id)"
    }
    var image: String {
        "apollo\(id)"
    }
    var formattedLaunchDate: String {
        launchDate?.formatted(date: . abbreviated, time: .omitted) ?? "N/A"
    }
    
    var detailedLaunchDate: String {
        launchDate?.formatted(date: .long, time: .shortened) ?? "N/A"
    }
}
