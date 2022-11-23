//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Daan Schutte on 23/11/2022.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
