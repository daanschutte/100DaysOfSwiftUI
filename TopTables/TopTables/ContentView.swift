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
    @State private var random = false
    
    var body: some View {
        VStack {
            HStack {
                if !random {
                    Stepper(
                        value: $base,
                        in: 1...12,
                        step: 1) {
                            Text("\(base) x Table")
                                .font(.headline.bold())
                        }
                }
                
                Toggle(isOn: $random) {
                    Text("Random")
                        .font(.subheadline)
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }.padding(.leading)
            }
            .padding(.horizontal)
            
            HStack {
                Stepper(value: $numQuestions, in: 5...15, step: 5) {
                    Text("\(numQuestions) questions")
                        .font(.headline.bold())
                        .frame(maxWidth: .infinity, alignment: .leading)
                }
                .padding(.horizontal)
            }
            
            Button("Start") {
                startGame()
            }
            .buttonStyle(.borderedProminent)
            .padding()
        }
    }
    
    func createQuestionList(_ random: Bool = false) {
        questions.removeAll()
        for n in 1...numQuestions {
            let base = random ? Int.random(in: 1...12) : base
            let n = random ? Int.random(in: 1...12) : n
            let question = Question(problem: "\(base) x \(n) =", answer: base * n)
            questions.append(question)
        }
        
        if random {
            questions.shuffle()
        }
    }
    
    func startGame() {
        gameInProgress = true
        createQuestionList(random)
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
                        Image(systemName: question.isCorrect() ? "hand.thumbsup" : "hand.thumbsdown")
                    }
                }
            }
            
            Button("Calculate Score") {
                calculateScore()
                showingScore = true
                showingResults = true
            }
            .buttonStyle(.borderedProminent)
            .alert("Score", isPresented: $showingScore) {
            } message: {
                Text("You have \(score)/\(questions.count) correct answers!")
            }
            .padding(15)
            
            
            Spacer()
            Button("Reset Game", role: .destructive) {
                score = 0
                showingResults = false
                
                reset()
            }
            .padding(.horizontal)
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
                        .padding()
                } else  {
                    SettingsView(base: $base, gameInProgress: $gameInProgress, questions: $questions)
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
