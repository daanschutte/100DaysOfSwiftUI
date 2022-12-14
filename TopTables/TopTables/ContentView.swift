//
//  ContentView.swift
//  TopTables
//
//  Created by Daan Schutte on 23/10/2022.
//

import SwiftUI

struct Question {
    let id: UUID = UUID.init()
    let problem: String
    let answer: Int
    var userAttempt: String = ""
}

extension Question: Identifiable {
    func isCorrect() -> Bool {
        return (Int(self.userAttempt) ?? -1) == self.answer
    }
}


struct SettingsView: View {
    @Binding var base: Int
    @Binding var gameInProgress: Bool
    @Binding var questions: [Question]
    
    @State private var numQuestions = 5
    
    @State private var randomTable = false
    @State private var randomMultiple = false
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    if randomTable {
                        Text("? x Table")
                    } else {
                        Stepper(
                            value: $base,
                            in: 1...12,
                            step: 1) {
                                Text("\(base) x Table")
                            }
                    }
                    
                    Toggle("Random table", isOn: Binding(
                        get: { randomTable },
                        set: { newValue in
                            randomTable = newValue
                        })
                    )
                    
                    Toggle("Random multiple", isOn: Binding(
                        get: { randomMultiple },
                        set: { newValue in
                            randomMultiple = newValue
                        })
                    )
                } header: {
                    Text("Multiplication Table")
                }
                
                Section {
                    Toggle("Quiz mode", isOn: Binding(
                        get: { randomMultiple && randomTable },
                        set: { newValue in
                            randomTable = newValue
                            randomMultiple = newValue
                        })
                    )

                    HStack {
                        Stepper(value: $numQuestions, in: 5...15, step: 5) {
                            HStack {
                                Text("Number of questions")
                                Spacer()
                                Text("\(numQuestions)")
                            }
                        }
                    }
                    
                } header: {
                    Text("Settings")
                }
            }
            
            Button("Start Game") {
                startGame()
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .padding()
        }
    }
    
    func createQuestionList() {
        questions.removeAll()
        
        let quizMode = randomTable && randomMultiple
        let b = randomTable ? Int.random(in: 1...12) : base
        
        for n in 1...numQuestions {
            let b = quizMode ? Int.random(in: 1...12) : b
            let n = randomMultiple || quizMode ? Int.random(in: 1...12) : n
            let question = Question(problem: "\(b) x \(n) =", answer: b * n)
            questions.append(question)
        }
        
        if randomMultiple {
            questions.shuffle()
        }
    }
    
    func startGame() {
        gameInProgress = true
        createQuestionList()
    }
}

struct GameView: View {
    @Binding var base: Int
    @Binding var gameInProgress: Bool
    @Binding var questions: [Question]
    
    @State private var showingScore = false
    @State private var showingResults = false
    @State private var score = 0
    
    var reset: () -> Void
    
    var body: some View {
        VStack {
            List($questions) { $question in
                HStack {
                    Text(question.problem)
                    TextField("?", text: $question.userAttempt)
                        .disableAutocorrection(true)
                        .keyboardType(.numberPad)
                    if showingResults && !question.userAttempt.isEmpty {
                        let correct = question.isCorrect()
                        Image(systemName: correct ? "hand.thumbsup" : "hand.thumbsdown")
                            .foregroundColor(correct ? .green : .red)
                    }
                }
            }
            
            Button("Calculate Score") {
                calculateScore()
                showingScore = true
                showingResults = true
            }
            .buttonStyle(.borderedProminent)
            .controlSize(.large)
            .disabled(showingResults && score > 0)
            .alert("Score", isPresented: $showingScore) {
            } message: {
                Text("You have \(score)/\(questions.count) correct answers!")
            }
            .padding(10)
            
            
            Spacer()
            Button("Reset Game", role: .destructive) {
                score = 0
                showingResults = false
                
                reset()
            }
            .buttonStyle(.bordered)
            .controlSize(.large)
            .padding(.bottom, 30)
        }
    }
    
    func calculateScore() {
        var result = 0
        for question in questions {
            if question.isCorrect() {
                result += 1
            }
        }
        score = result
    }
}

struct ContentView: View {
    @State private var base = 1
    @State private var gameInProgress = false
    @State private var questions = [Question]()
    
    var body: some View {
        
        NavigationStack {
            VStack {
                if gameInProgress {
                    GameView(base: $base, gameInProgress: $gameInProgress, questions: $questions, reset: reset)
                } else  {
                    SettingsView(base: $base, gameInProgress: $gameInProgress, questions: $questions)
                        .padding(.top, 25)
                    
                    Spacer()
                }
            }
            .navigationTitle(Text("Table Monster"))
        }
    }
    
    func reset() {
        gameInProgress = false
        base = 1
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
