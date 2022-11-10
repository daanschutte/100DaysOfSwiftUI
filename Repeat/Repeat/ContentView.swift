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
                        // TODO: make this an navigation link
                        Text(activity.name)
                    }
                    .onDelete(perform: removeItems)
                }
            }
            .navigationTitle("OnRepeat")
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
