//
//  EditCardView.swift
//  Flashzilla
//
//  Created by Daan Schutte on 09/01/2023.
//

import SwiftUI

struct EditCardsView: View {
    @Environment(\.dismiss) var dismiss
    
    @State private var cards = Array(repeating: Card.example, count: 3)
    //    @State private var cards = [Card]()
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt:", text: $newPrompt)
                    TextField("Answer:", text: $newAnswer)
                    Button("Add", action: addCard)
                }
                
                Section {
                    ForEach(0..<cards.count, id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(cards[index].prompt)
                                .font(.headline)
                            Text(cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete(perform: removeCard)
                }
                
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                ToolbarItem {
                    Button("Done", action: done)
                }
            }
            .listStyle(.grouped)
            .onAppear(perform: loadData)
        }
    }
    
    func removeCard(at offset: IndexSet) {
        cards.remove(atOffsets: offset)
        saveData()
    }
    
    func addCard() {
        let trimmedPrompt = newPrompt.trimmingCharacters(in: .whitespaces)
        let trimmedAnswer = newAnswer.trimmingCharacters(in: .whitespaces)
        
        guard !trimmedPrompt.isEmpty && !trimmedAnswer.isEmpty else { return }
        
        let newCard = Card(prompt: trimmedPrompt, answer: trimmedAnswer)
        cards.insert(newCard, at: 0)
        
        newPrompt = ""
        newAnswer = ""
        
        saveData()
    }
    
    func saveData() {
        if let data = try? JSONEncoder().encode(cards) {
            UserDefaults.standard.set(data, forKey: "Cards")
        }
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Cards") {
            if let decoded = try? JSONDecoder().decode([Card].self, from: data) {
                cards = decoded
            }
        }
    }
    
    func done() {
        dismiss()
    }
}

struct EditCardView_Previews: PreviewProvider {
    static var previews: some View {
        EditCardsView()
    }
}
