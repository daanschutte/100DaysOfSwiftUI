//
//  Favourites.swift
//  SnowSeeker
//
//  Created by Daan Schutte on 11/01/2023.
//

import Foundation

class Favourites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favourites"
    
    init() {
        // load our save data
        
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func addResort(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func removeResort(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // write out our data
    }
}
