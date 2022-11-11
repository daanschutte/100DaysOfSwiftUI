//
//  ContentView.swift
//  Repeat
//
//  Created by Daan Schutte on 09/11/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Bundle.main.decode("history.json") // TODO: fix
    
    @State private var showingSheet = false
    
    // TODO: NEXT: Persist activities
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    ForEach(activities.items) { activity in
                        HStack {
                            // TODO: make this an navigation link
                            VStack(alignment: .leading) {
                                Text(activity.type)
                                    .font(.headline)
                                Text(activity.completed.formatted())
                                    .font(.footnote)
                            }
                            .padding(.horizontal)
                            
                            Text(activity.notes)
                                .font(.caption)
                                .multilineTextAlignment(.leading)
                        }
                    }
                    .onDelete(perform: removeItems)
                    .padding(5)
                }
            }
            .navigationTitle("Again.")
            .toolbar {
                ToolbarItem {
                    Button {
                        showingSheet.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
                    .sheet(isPresented: $showingSheet) {
                        ActivitiesView(activities: activities)
                    }
                    .padding(.horizontal)
                }
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
