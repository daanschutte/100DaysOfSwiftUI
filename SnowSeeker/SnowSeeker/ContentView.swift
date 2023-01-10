//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Daan Schutte on 10/01/2023.
//

import SwiftUI

struct User: Identifiable {
    var id = "Tay Tay"
}

struct ContentView: View {
    @State private var selectedUser: User? = nil
    @State private var isShowingUser = false
    
    var body: some View {
        Text("Hello, world!")
            .onTapGesture {
                selectedUser = User()
            }
            .sheet(item: $selectedUser) { user in
                Text(user.id)
                    .onTapGesture {
                        isShowingUser = true
                    }
                    .alert("Eat it Kanye", isPresented: $isShowingUser) { }
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
