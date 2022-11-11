//
//  ActivityItem.swift
//  Repeat
//
//  Created by Daan Schutte on 10/11/2022.
//

import Foundation

struct ActivityItem: Identifiable, Codable {
    var id = UUID()
    let type: String
    let completed: Date
    let notes: String
    
    var formattedCompleted: String {
        "\(completed.formatted(date: .abbreviated, time: .omitted))\n\(completed.formatted(date: .omitted, time: .shortened))"
    }
}
