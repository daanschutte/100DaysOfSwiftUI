//
//  User.swift
//  FriendFace
//
//  Created by Daan Schutte on 28/11/2022.
//

import Foundation

class User: ObservableObject {
    @Published var data: UserData

    required init(
        id: UUID,
        isActive: Bool,
        age: Int,
        name: String,
        company: String,
        email: String,
        address: String,
        about: String,
        registered: Date,
        tags: [String],
        friends: [UUID]
    ) {
        self.data = UserData(
            id: id,
            isActive: isActive,
            age: age,
            name: name,
            company: company,
            email: email,
            address: address,
            about: about,
            registered: registered,
            tags: tags,
            friends: friends
        )
    }
}

struct UserData: Codable {
    enum CodingKeys: CodingKey {
        case id, isActive, age, name, company, email, address, about, registered, tags, friends
    }

    var id: UUID
    var isActive: Bool
    var age: Int
    var name: String
    var company: String
    var email: String
    var address: String
    var about: String
    var registered: Date
    var tags: [String]
    var friends: [UUID]
}
