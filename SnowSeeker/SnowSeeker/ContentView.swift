//
//  ContentView.swift
//  SnowSeeker
//
//  Created by Daan Schutte on 10/01/2023.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    
    let allNames = ["Kaladin", "Moash", "Shallan", "Szeth"]
    
    var body: some View {
        NavigationView {
            List(filterNames, id: \.self) { name in
                Text(name)
            }
            .searchable(text: $searchText, prompt: "Look for something")
            .navigationTitle("Searching")
        }
    }
    
    var filterNames: [String] {
        if searchText.isEmpty {
            return allNames
        } else {
            return allNames.filter { $0.localizedCaseInsensitiveContains(searchText) }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
