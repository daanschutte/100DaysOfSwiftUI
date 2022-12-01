//
//  UserView.swift
//  FriendFace
//
//  Created by Daan Schutte on 29/11/2022.
//

import SwiftUI

struct UserView: View {
    var user: User
    
    var body: some View {
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
                Text("\(user.name) is \(user.age) years old")
                Text("Their email is \(user.email)")
                VStack(alignment: .leading){
                    Text("They live at:")
                    Text("\(user.address)")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .multilineTextAlignment(.leading)
                Text("First joined on \(user.formattedDate)")
            } header:  {
                Text("Personal info")
            }
            
            Section {
                Text("Company: \(user.company)")
                
            } header: {
                Text("Professional info")
            }
            
            Section {
                Text("\(user.about)")
            } header: {
                Text("About")
            }
            
            Section {
                ForEach(user.friends) { friend in
                    NavigationLink {
                        Text("Friend View")
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

struct UserView_Previews: PreviewProvider {
    static var previews: some View {
        let mary = Friend(id: UUID(), name: "Mary")
        let stacey = Friend(id: UUID(), name: "Stacey")
        
        NavigationStack {
            UserView(
                user: User(
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
                    friends: [mary, stacey]
                )
            )
        }
    }
}
