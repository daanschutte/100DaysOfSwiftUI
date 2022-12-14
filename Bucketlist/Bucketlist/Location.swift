//
//  Location.swift
//  Bucketlist
//
//  Created by Daan Schutte on 14/12/2022.
//

import Foundation

struct Location: Identifiable, Codable, Equatable {
    let id: UUID
    var name: String
    var description: String
    let latitude: Double
    let longitude: Double
}
