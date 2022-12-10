//
//  Client.swift
//  FriendFace
//
//  Created by Daan Schutte on 10/12/2022.
//

import Foundation

struct Client {
    func getUsersFromAPI() async -> [User]? {
        let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")!
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        
        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                return decodedResponse
            } else {
                print("Could not decode user data")
            }
        } catch {
            print(error)
        }
        return nil
    }
}
