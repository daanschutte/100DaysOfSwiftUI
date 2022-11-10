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
    
    @State private var description = ""
    @State private var completed = Date()

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Description", text: $description)
                    
                    DatePicker("Date", selection: $completed)
                    
                    Button("Add") {
                        let activity = ActivityItem(name: description, completed: completed)
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
