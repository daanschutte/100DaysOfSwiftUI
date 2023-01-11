//
//  Favourites.swift
//  SnowSeeker
//
//  Created by Daan Schutte on 11/01/2023.
//

import Foundation

class Favourites: ObservableObject {
    private var favourites = Set<String>()
    private let dataKey = "favourites.json"
    
    init() {
        loadData()
    }
    
    func contains(_ resort: Resort) -> Bool {
        favourites.contains(resort.id)
    }
    
    func addResort(_ resort: Resort) {
        objectWillChange.send()
        favourites.insert(resort.id)
        saveData()
    }
    
    func removeResort(_ resort: Resort) {
        objectWillChange.send()
        favourites.remove(resort.id)
        saveData()
    }
    
    func saveData() {
        if let data = try? JSONEncoder().encode(favourites) {
            UserDefaults.standard.set(data, forKey: dataKey)
        }
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: dataKey) {
            if let decoded = try? JSONDecoder().decode(Set<String>.self, from: data) {
                favourites = decoded
            }
        }
    }
}
