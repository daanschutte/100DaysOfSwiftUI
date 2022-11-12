//
//  Activity.swift
//  Repeat
//
//  Created by Daan Schutte on 09/11/2022.
//

import Foundation

class Activities: ObservableObject {
    @Published var items: [String: [ActivityItem]] = [:]
    
    func completedCount(by type: String) -> Int {
        return items[type]?.count ?? 0
    }
    
    func lastCompleted(type: String) -> ActivityItem? {
        return items[type]?
            .sorted {
                return $0.completed < $1.completed
            }
            .last
    }
    
    func activityTypes() -> [String] {
        return items.keys.sorted()
    }
}
