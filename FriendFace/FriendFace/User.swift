//
//  User.swift
//  FriendFace
//
//  Created by Daan Schutte on 28/11/2022.
//

import Foundation

struct User: Codable, Identifiable {
    let id: UUID
    let isActive: Bool
    let age: Int
    let name: String
    let company: String
    let email: String
    let address: String
    let about: String
    let registered: Date
    let tags: [String]
    let friends: [Friend]
    
    var formattedDate: String {
        registered.formatted(date: .abbreviated, time: .omitted)
    }
    
    var initials: String {
        return name
            .split(separator: " ")
            .map { $0.first?.description ?? "X" }
            .map { $0.uppercased() }
            .joined(separator: "")
    }
}
