//
//  ContentView.swift
//  Repeat
//
//  Created by Daan Schutte on 09/11/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject var activities = Activities()
    
    @State private var showingSheet = false
    
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
        .onAppear(perform: loadHistory)
    }
    
    func removeItems(at offsets: IndexSet) {
        activities.items.remove(atOffsets: offsets)
    }
    
    func loadHistory() {
        let activityItems: [ActivityItem] = Bundle.main.decode("history.json")
        activities.items = activityItems
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
