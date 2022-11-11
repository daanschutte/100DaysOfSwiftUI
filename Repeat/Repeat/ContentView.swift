//
//  ContentView.swift
//  Repeat
//
//  Created by Daan Schutte on 09/11/2022.
//

import SwiftUI


struct ActivityLabelLayout: View {
    @State var activity: ActivityItem
    
    var body: some View {
        HStack {
            VStack(alignment: .center) {
                Text(activity.type)
                    .font(.headline)
                Text(activity.formattedCompleted)
                    .font(.caption)
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal)
            
            Text(activity.notes)
                .font(.caption)
                .multilineTextAlignment(.leading)
        }
    }
}


struct ContentView: View {
    @StateObject var activities = Activities()
    
    @State private var showingSheet = false
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    ForEach(activities.items) { activity in
                        NavigationLink {
                            // TODO: Replace with edit view
                            Text("edit single activity view")
                        } label: {
                            ActivityLabelLayout(activity: activity)
                        }
                    }
                    .onDelete(perform: removeItems)
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
    
    func loadHistory() {
        let activityItems: [ActivityItem] = Bundle.main.decode("history.json")
        activities.items = activityItems
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
