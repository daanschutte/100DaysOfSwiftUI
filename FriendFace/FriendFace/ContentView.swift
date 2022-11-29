//
//  ContentView.swift
//  FriendFace
//
//  Created by Daan Schutte on 28/11/2022.
//

import SwiftUI

struct Response: Decodable {
   @StateObject var results: [User]
    
    init() {
        self.results = [User]()
    }
}

struct ContentView: View {
    @State private var results = [User]()
    
    var body: some View {
        VStack(alignment: .leading) {
            List(results, id: \.data.id) { user in
                Text(user.data.name)
            }
        }
        .task {
            await loadData()
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                results = decodedResponse.results
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
