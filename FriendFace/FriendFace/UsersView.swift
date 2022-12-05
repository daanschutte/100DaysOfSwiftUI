//
//  UserView.swift
//  FriendFace
//
//  Created by Daan Schutte on 29/11/2022.
//

import SwiftUI

struct UsersView: View {
    var users: [User]
    var selected_id: UUID

    var body: some View {
        let user: User =
            users.filter { user in
                user.id == selected_id
            }.first ?? userNotFound()

        Text(user.initials)
            .font(.largeTitle)
            .padding(60)
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(user.isActive ? Color.green : Color.red)
            )
            .padding(20)
            .frame(maxWidth: .infinity, alignment: .center)

        List {
            Section {
                Text("\(user.age) years old")
                Text(user.email)
                VStack(alignment: .leading) {
                    Text("Address:")
                    Text(user.address)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal)
                }
                .multilineTextAlignment(.leading)
                Text("Joined \(user.formattedDate)")
            } header: {
                Text("Personal info")
            }

            Section {
                Text(user.company)

            } header: {
                Text("Company")
            }

            Section {
                Text("\(user.about)")
            } header: {
                Text("About")
            }

            Section {
                ForEach(user.friends) { friend in
                    NavigationLink {
                        UsersView(users: users, selected_id: friend.id)
                    } label: {
                        Text(friend.name)
                    }
                }
            } header: {
                Text("Friends")
            }

            Section {
                ForEach(user.tags, id: \.self) {
                    Text($0)
                }
            } header: {
                Text("Tags")
            }
        }
        .navigationTitle(user.name)

    }
}

func userNotFound() -> User {
    return User(
        id: UUID(),
        isActive: false,
        age: 0,
        name: "Not found",
        company: "not available",
        email: "In the real app this should not be possible, since friends will be generated from existing users.",
        address: "",
        about: "User not found.\nNormally this would be handled with a popup or something more appropriate.",
        registered: Date(),
        tags: [String](),
        friends: [Friend]()
    )
}

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        let mary = Friend(id: UUID(), name: "Mary")
        let stacey = Friend(id: UUID(), name: "Stacey")

        let chad = User(
            id: UUID(),
            isActive: true,
            age: 21,
            name: "Chad Thunderclock",
            company: "The gym, bro",
            email: "chad@thunderclock69.com",
            address: "Moms house, naturally",
            about: "Do you even lift, bro?",
            registered: Date(),
            tags: ["gymbro", "gymlife", "Male"],
            friends: [stacey, mary]
        )
        let fChad = Friend(id: chad.id, name: "Chad Thunderclock")

        let jed = User(
            id: UUID(),
            isActive: true,
            age: 23,
            name: "Jed Cucks",
            company: "Congo Logistics",
            email: "congo@rainforest.com",
            address: "Goma\n3rd hill on the right\nDRC",
            about: "This guy fuchs",
            registered: Date(),
            tags: ["Bozo", "Male", "Bonehead"],
            friends: [mary, stacey, fChad]
        )


        let users = [jed, chad]

        NavigationStack {
            UsersView(
                users: users,
                selected_id: jed.id
            )
        }
    }
}
