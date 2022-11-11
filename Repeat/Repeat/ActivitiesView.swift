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
    
    @State private var type = UserDefaults.standard.string(forKey: "PreviousActivityType") ?? "Unknown"
    @State private var completed = Date()
    @State private var notes = ""
    
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
                        let activity = ActivityItem(type: type, completed: completed, notes: notes)
                        activities.items.append(activity)
                        
                        UserDefaults.standard.set(self.type, forKey: "PreviousActivityType")
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
