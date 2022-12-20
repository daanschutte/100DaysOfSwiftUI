//
//  Person.swift
//  Recall
//
//  Created by Daan Schutte on 19/12/2022.
//

import Foundation
import SwiftUI

struct Person: Identifiable, Comparable, Codable {
    private enum CodingKeys: CodingKey {
        case id, name
    }
    
    let id: UUID
    var name: String
    var image: Image?
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
