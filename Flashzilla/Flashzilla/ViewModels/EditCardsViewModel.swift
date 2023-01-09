//
//  EditCardsViewModel.swift
//  Flashzilla
//
//  Created by Daan Schutte on 09/01/2023.
//

import Foundation

extension EditCardsView {
    @MainActor class ViewModel: ObservableObject {
        
        @Published private(set) var cards = [Card]()
        
        private let dataKey = "Cards"
        
        func removeCard(at offset: IndexSet) {
            Task {
                await MainActor.run {
                    cards.remove(atOffsets: offset)
                    saveData()
                }
            }
        }
        
        func addCard(_ newPrompt: String, _ newAnswer: String) {
            let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
            let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
            
            guard !trimmedPrompt.isEmpty && !trimmedAnswer.isEmpty else { return }
            
            let newCard = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
            cards.insert(newCard, at: 0)
            
            saveData()
        }
        
        func saveData() {
            if let data = try? JSONEncoder().encode(cards) {
                UserDefaults.standard.set(data, forKey: dataKey)
            }
        }
        
        func loadData() {
            Task {
                await MainActor.run {
                    if let data = UserDefaults.standard.data(forKey: dataKey) {
                        if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                            cards = decoded
                        }
                    }
                }
            }
        }
        
        
        
        func cardCount() -> Int {
            cards.count
        }
    }
}
