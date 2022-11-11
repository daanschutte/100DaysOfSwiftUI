//
//  Activity.swift
//  Repeat
//
//  Created by Daan Schutte on 09/11/2022.
//

import Foundation

class Activities: ObservableObject, Codable {
    @Published var items = [ActivityItem]()
}
