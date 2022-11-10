//
//  ActivityItem.swift
//  Repeat
//
//  Created by Daan Schutte on 10/11/2022.
//

import Foundation

struct ActivityItem: Identifiable {
    let id = UUID()
    let name: String
    let completed: Date
}
