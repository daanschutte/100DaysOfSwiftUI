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

    @State private var newName = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                Form {
                    TextField("Activity name", text: $newName)
                    
                    Button("Add") {
                        activities.items[newName, default: []].append(contentsOf: [])
                        
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
            .navigationTitle("Add new activity")
        }
    }
}

struct ActivitiesView_Previews: PreviewProvider {
    static var previews: some View {
        ActivitiesView(activities: Activities())
    }
}
