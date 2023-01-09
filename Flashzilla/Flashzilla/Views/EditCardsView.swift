//
//  EditCardView.swift
//  Flashzilla
//
//  Created by Daan Schutte on 09/01/2023.
//

import SwiftUI

struct EditCardsView: View {
    @Environment(\.dismiss) var dismiss
    
    @StateObject private var viewModel = ViewModel()
    
    @State private var newPrompt = ""
    @State private var newAnswer = ""
    
    var body: some View {
        NavigationView {
            List {
                Section("Add new card") {
                    TextField("Prompt:", text: $newPrompt)
                    TextField("Answer:", text: $newAnswer)
                    Button("Add"){
                        viewModel.addCard(newPrompt, newAnswer)
                        
                        newPrompt = ""
                        newAnswer = ""
                    }
                }
                
                Section {
                    ForEach(0..<viewModel.cardCount(), id: \.self) { index in
                        VStack(alignment: .leading) {
                            Text(viewModel.cards[index].prompt)
                                .font(.headline)
                            Text(viewModel.cards[index].answer)
                                .foregroundColor(.secondary)
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.removeCard(at: indexSet)
                    }
                }
            }
            .navigationTitle("Edit Cards")
            .toolbar {
                ToolbarItem {
                    Button("Done", action: done)
                }
            }
            .listStyle(.grouped)
            .onAppear { viewModel.loadData() }
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
