//
//  Person.swift
//  Recall
//
//  Created by Daan Schutte on 19/12/2022.
//

import Foundation
import SwiftUI

struct Person: Identifiable, Comparable {
//    enum CodingKeys: CodingKey {
//        case id, name, image
//    }
    
    let id = UUID()
    var name: String
    var image: Image
    
    static func < (lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
}
