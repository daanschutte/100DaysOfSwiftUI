//
//  ContentViewModel.swift
//  Flashzilla
//
//  Created by Daan Schutte on 09/01/2023.
//

import Foundation
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var cards = [Card]()
        
        @Published var isActive = true
        @Published var timeRemaining = 60
        
        func removeCard(at index: Int) {
            guard index >= 0 else { return }
            
            cards.remove(at: index)
            
            if cards.isEmpty {
                isActive = false
            }
        }
        
        func loadData() {
            if let data = UserDefaults.standard.data(forKey: "Cards") {
                if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                    cards = decoded
                }
            }
        }
        
        func resetCards() {
            loadData()
            timeRemaining = cards.count * 4
            isActive = true
        }
        
        func tick() {
            guard isActive else { return }
            
            if timeRemaining > 0 {
                timeRemaining -= 1
            }
        }
        
        func controlActive(phase: ScenePhase) {
            if phase == .active {
                if !cards.isEmpty {
                    isActive = true
                }
            } else {
                isActive = false
            }
        }
    }
}
