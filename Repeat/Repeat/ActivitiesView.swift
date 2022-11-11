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
    
    @State private var type = "Music" // TODO UserDefaults what was last property set?
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
                                        
                    DatePicker("Date", selection: $completed)
                    
                    TextField("Notes", text: $notes)
                    
                    Button("Add") {
                        let activity = ActivityItem(type: type, completed: completed, notes: notes)
                        activities.items.append(activity)
                        
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
