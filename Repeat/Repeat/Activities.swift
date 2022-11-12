//
//  Activity.swift
//  Repeat
//
//  Created by Daan Schutte on 09/11/2022.
//

import Foundation

class Activities: ObservableObject {
    @Published var items = [ActivityItem]()
    
    func completedCount(by type: String) -> Int {
        items.filter { $0.type == type }.count
    }
    
    func lastCompleted(type: String) -> ActivityItem? {
        return items
            .filter { $0.type == type }
            .sorted {
                return $0.completed < $1.completed
            }
            .last
    }
}
