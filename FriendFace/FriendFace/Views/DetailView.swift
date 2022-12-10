//
//  UserView.swift
//  FriendFace
//
//  Created by Daan Schutte on 29/11/2022.
//

import SwiftUI

struct DetailView: View {
    let user: CachedUser

    var body: some View {
        Text(user.initials ?? "XX")
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
                Text(user.wrappedEmail)
                VStack(alignment: .leading) {
                    Text("Address:")
                    Text(user.wrappedAddress)
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                        .padding(.horizontal)
                }
                .multilineTextAlignment(.leading)
                Text("Joined \(user.wrappedFormattedDate)")
            } header: {
                Text("Personal info")
            }

            Section {
                Text(user.wrappedCompany)

            } header: {
                Text("Company")
            }

            Section {
                Text(user.wrappedAbout)
            } header: {
                Text("About")
            }

            Section {
                ForEach(user.friendsArray) { friend in
                    Text(friend.wrappedName)
                }
            } header: {
                Text("Friends")
            }
        }
        .navigationTitle(user.wrappedName)

    }
}
