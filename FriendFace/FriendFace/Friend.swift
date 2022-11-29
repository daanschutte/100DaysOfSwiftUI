//
//  Friend.swift
//  FriendFace
//
//  Created by Daan Schutte on 28/11/2022.
//

import Foundation

class Friend: ObservableObject {
    @Published var data: FriendData

    required init(id: UUID, name: String) {
        data = FriendData(id: id, name: name)
    }

}

struct FriendData: Codable {
    enum CodingKeys: CodingKey {
        case id, name
    }

    var id: UUID
    var name: String
}
