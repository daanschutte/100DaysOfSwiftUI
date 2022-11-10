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
    
    @State private var description: String
    @State private var completed: Date

    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Description", text: $description)
                    
                    Button("Add") {
                        // TODO: REMOVE BELOW 2 LINES
                        let testActivity = ActivityItem(name: "test activity", completed: Date())
                        activities.items.append(testActivity)
                        
                        // TODO
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
