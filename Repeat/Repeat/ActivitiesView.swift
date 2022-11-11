//
//  ActivitiesView.swift
//  Repeat
//
//  Created by Daan Schutte on 10/11/2022.
//

import SwiftUI

struct ActivitiesView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var activities: Activities
    
    @AppStorage("PreviousActivityType") private var type = "Unknown"
    
    @State private var completed = Date()
    @State private var notes = ""
    
    // Usually this would be an UUID but here we don't want to deal with encoding JSON
    @State private var currentId = 3

    let activityTypes = ["Music", "Reading", "Exercise"]
    
    // TODO: allow adding new activity
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    Picker("Activity Type", selection: $type) {
                        ForEach(activityTypes, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.automatic)
                    
                    DatePicker("Date", selection: $completed)
                    TextField("Notes", text: $notes)
                    
                    Button("Add") {
                        let activity = ActivityItem(id: currentId, type: type, completed: completed, notes: notes)
                        currentId += 1 // see note at property declaration
                        
                        activities.items.append(activity)
                        
                        dismiss()
                    }
                }
            }
            .toolbar {
                ToolbarItem {
                    Button("Cancel") {
                        dismiss()
                    }
                }
            }
            .navigationTitle("Activities")
        }
    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView(activities: Activities())
    }
}
