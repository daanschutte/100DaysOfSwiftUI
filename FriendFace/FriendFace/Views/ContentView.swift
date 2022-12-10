//
//  ContentView.swift
//  FriendFace
//
//  Created by Daan Schutte on 28/11/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    
    @FetchRequest(sortDescriptors: []) var cachedUsers: FetchedResults<CachedUser>
    
    @State private var users = [User]()
    
    let client = Client()
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                List(cachedUsers) { user in
                    NavigationLink {
                        DetailView(user: user)
                    } label: {
                        Text(user.wrappedName)
                    }
                }
            }
            .navigationTitle("FriendFace")
            .task {
                if cachedUsers.isEmpty {
                    if let retrievedUsers = await client.getUsersFromAPI() {
                        users = retrievedUsers
                    }
                    
                    await MainActor.run {
                        for user in users {
                            let newUser = CachedUser(context: moc)
                            newUser.id = user.id
                            newUser.address = user.address
                            newUser.about = user.about
                            newUser.age = Int16(user.age)
                            newUser.company = user.company
                            newUser.email = user.email
                            newUser.formattedDate = user.formattedDate
                            newUser.isActive = user.isActive
                            newUser.name = user.name
                            
                            for friend in user.friends {
                                let newFriend = CachedFriend(context: moc)
                                newFriend.id = friend.id
                                newFriend.name = friend.name
                                newFriend.user = newUser
                            }
                            
                            try? moc.save()
                        }
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
