//
//  ContentView.swift
//  FriendFace
//
//  Created by Daan Schutte on 28/11/2022.
//

import SwiftUI

struct ContentView: View {
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
                if users.count <= 0 {
                    print("Fetching users")
                    await loadData()
                } else {
                    print("Using existing users")
                }
            }
        }
    }

    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json")
        else {
            print("Invalid URL")
            return
        }

        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            if let decodedResponse = try? decoder.decode([User].self, from: data) {
                users = decodedResponse
            } else {
                print("Could not decode user data")
            }
        } catch {
            print("Invalid data")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
