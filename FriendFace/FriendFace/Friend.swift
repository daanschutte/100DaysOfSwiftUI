//
//  Friend.swift
//  FriendFace
//
//  Created by Daan Schutte on 28/11/2022.
//

import Foundation

struct Friend: Codable, Identifiable {
    let id: UUID
    let name: String
}
