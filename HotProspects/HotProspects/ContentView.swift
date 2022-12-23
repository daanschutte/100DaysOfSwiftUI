//
//  ContentView.swift
//  HotProspects
//
//  Created by Daan Schutte on 22/12/2022.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        List {
            Text("Taylor Swift")
                .swipeActions {
                    Button(role: .destructive) {
                        print("Deleting")
                    } label: {
                        Label("Delete", systemImage: "minus.circle")
                    }
                }
                .swipeActions(edge: .leading) {
                    Button {
                        print("Pinnig")
                    } label : {
                        Label("Pin", systemImage: "pin")
                    }
                    .tint(.orange)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
