//
//  ContentView.swift
//  WordScramble
//
//  Created by Daan Schutte on 20/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var showingError = false
    
    @State private var score = 0
    
    let minWordLength = 3
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    TextField("Enter your word", text: $newWord)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                }
                
                if !usedWords.isEmpty {
                    Section("Score") {
                        HStack {
                            Spacer()
                            
                            ForEach(3..<9) { i in
                                let words = usedWordsWithLength(chars: i)
                                if words > 0 {
                                    HStack {
                                        Image(systemName: "\(i).circle")
                                        Text("= \(words)")
                                    }
                                }
                            }
                            
                            Spacer()
                        }
                        .font(.footnote)
                        
                        HStack {
                            Spacer()
                            Text("Total words: \(usedWords.count)")
                            Spacer()
                            Text("Total score: \(score)")
                            Spacer()
                        }
                        .font(.footnote)
                    }
                    
                    
                    Section("Word list") {
                        ForEach(usedWords, id: \.self) { word in
                            HStack {
                                Text(word)
                                Image(systemName: "\(word.count).circle")
                            }
                        }
                    }
                }
            }
            .navigationTitle(rootWord)
            .onSubmit(addNewWord)
            .onAppear(perform: startGame)
            .toolbar {
                Button("Start Game") {
                    startGame()
                }
            }
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) {
                }
            } message: {
                Text(errorMessage)
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count >= minWordLength else {
            wordError(title: "Word too short", message: "Words should contain at least \(minWordLength) characters!")
            return
        }
        
        guard isOriginal(word: answer) else {
            wordError(title: "Word used already", message: "Be more original!")
            return
        }
        
        guard isPossible(word: answer) else {
            wordError(title: "Word not possible", message: "You can't spell that word from \"\(rootWord)\"")
            return
        }
        
        guard isReal(word: answer) else {
            wordError(title: "Word not recognised", message: "You can't just make them up, you know!")
            return
        }
        
        withAnimation {
            usedWords.insert(answer, at: 0)
        }
        
        score += calculateWordScore()
        newWord = ""
    }
    
    func startGame() {
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allWords = startWords.components(separatedBy: "\n")
                rootWord = allWords.randomElement() ?? "silkworm"
                usedWords = [String]()
                newWord = ""
                return
            }
        }
        
        fatalError("Could not load start.txt from bundle.")
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word) && newWord != rootWord
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        
        return true
    }
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
        newWord = ""
    }
    
    func usedWordsWithLength(chars: Int) -> Int {
        return usedWords.filter { word in
            return word.count == chars
        }
        .count
        
    }
    
    func calculateWordScore() -> Int {
        return (newWord.count - 2) * 2
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
