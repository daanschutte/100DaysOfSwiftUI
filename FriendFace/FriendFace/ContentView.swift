//
//  ContentView.swift
//  FriendFace
//
//  Created by Daan Schutte on 28/11/2022.
//

import SwiftUI

struct ContentView: View {
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    @State private var users = [User]()

    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List(users) { user in
                    NavigationLink {
                        UsersView(users: users, selected_id: user.id)
                    } label: {
                        Text(user.name)
                    }
                }
            }
            .navigationTitle("FriendFace")
            .task {
                if let retrievedUsers = await loadData() {
                    print("Users loaded")
                    users = retrievedUsers
                }
            }
        }
    }
    
    func loadData() async -> [User]? {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return nil
        }
        
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
