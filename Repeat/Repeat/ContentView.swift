//
//  ContentView.swift
//  Repeat
//
//  Created by Daan Schutte on 09/11/2022.
//

import SwiftUI


struct ActivityLabelLayout: View {
    @State var activity: ActivityItem
    @State var totalCompleted: Int
    
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

            Spacer()

            VStack(alignment: .center) {
                Text("\(totalCompleted)")
                    .font(.headline)
                    .foregroundColor(.blue)
                
                Text("Total")
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            .padding(.trailing)
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
                    ForEach(activityTypes(), id: \.self) { type in
                        if let last = lastCompleted(type: type) {
                            NavigationLink {
                                // TODO: Replace with edit view
                                Text("all items from single activity view")
                            } label: {
                                ActivityLabelLayout(activity: last, totalCompleted: completedCount(by: last.type))
                            }
                        }
                    }
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
        
        for item in activityItems {
            activities.items[item.type, default: []].append(item)
        }
    }
    
    func completedCount(by type: String) -> Int {
        return activities.items[type]?.count ?? 0
    }
    
    func lastCompleted(type: String) -> ActivityItem? {
        return activities.items[type]?
            .sorted {
                return $0.completed < $1.completed
            }
            .last
    }
    
    func activityTypes() -> [String] {
        return activities.items.keys.sorted()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
