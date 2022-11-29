//
//  User.swift
//  FriendFace
//
//  Created by Daan Schutte on 28/11/2022.
//

import Foundation

class User: ObservableObject {
    @Published var data: UserData

     init() {
         self.data = UserData(id: UUID(), isActive: true, age: 0, name: "", company: "", email: "", address: "", about: "", registered: Date(), tags: [String](), friends: [FriendData]())
     }
}

struct UserData: Decodable {
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
    var friends: [FriendData]
}
