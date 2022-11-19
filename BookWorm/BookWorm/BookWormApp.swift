//
//  BookWormApp.swift
//  BookWorm
//
//  Created by Daan Schutte on 19/11/2022.
//

import SwiftUI

@main
struct BookWormApp: App {
    @State private var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
