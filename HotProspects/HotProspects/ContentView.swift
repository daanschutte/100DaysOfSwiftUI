//
//  ContentView.swift
//  HotProspects
//
//  Created by Daan Schutte on 22/12/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var output = ""
    
    var body: some View {
        Text(output)
            .task {
                await fetchDataOutput()
            }
    }
    
    func fetchDataOutput() async {
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }
        
        let result = await fetchTask.result
        
        switch result {
            case .success(let str):
                output = str
            case .failure(let error):
                output = "Dounload error: \(error.localizedDescription)"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
