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

struct ContentView: View {
    @State private var baseNumber = 1
    @State private var numQuestions = 5
    @State private var questions = [Question]()
    
    @State private var gameInProgress = false
    @State private var showingScore = false
    
    @State private var total = 0
    
    var body: some View {
        
        // TODO: Extract into own view
        if !gameInProgress {
            VStack {
                Stepper(value: $baseNumber, in: 1...12, step: 1) {
                    HStack{
                        Text("Which times table?")
                        Spacer()
                        Text("\(baseNumber)")
                    }
                }
                .padding(.horizontal)
                
                Stepper(value: $numQuestions, in: 5...15, step: 5) {
                    HStack{
                        Text("Up to which multiple?")
                        Spacer()
                        Text("\(numQuestions)")
                    }
                }
                .padding(.horizontal)

                Button("Start") {
                    startGame()
                }
                .buttonStyle(.borderedProminent)
            }
        }
        
        // TODO: this should be if/else or some better construct
        if gameInProgress {
            VStack {
                List($questions) { $question in
                    HStack {
                        Text(question.problem)
                        TextField("Answer", text: $question.userAttempt)
                            .disableAutocorrection(true)
                            .keyboardType(.numberPad)
                        if !question.userAttempt.isEmpty {
                            Image(systemName: question.isCorrect() ? "hand.thumbsup" : "hand.thumbsdown")
                        }
                    }
                    
                }
                
                Button("Calculate Score") {
                    calculateScore()
                    showingScore = true
                }
                .buttonStyle(.borderedProminent)
                .alert("Score", isPresented: $showingScore) {
                } message: {
                    Text("You have \(total)/\(questions.count) correct answers!")
                }
                .padding(15)

                
                Spacer()
                Button("Reset Game", role: .destructive) {
                    reset()
                }
                
                .padding(.horizontal)
            }
        }
        
    }
    
    func startGame() {
        gameInProgress = true
        createQuestionList()
    }
    
    func createQuestionList() {
        questions.removeAll()
        for n in 1...numQuestions {
            let question = Question(problem: "\(baseNumber) x \(n)", answer: baseNumber * n)
            questions.append(question)
        }
    }
    
    
    func createRandomQuestionList() {
        questions.removeAll()
        for _ in 0..<numQuestions {
            questions.append(createRandomQuestion(base: baseNumber))
        }
        
        questions.sort {
            return $0.answer < $1.answer
        }
    }
    
    func createRandomQuestion(base: Int) -> Question {
        let n = Int.random(in: 1...12)
        return Question(problem: "\(base) x \(n) = ", answer: baseNumber * n)
    }
    
    func calculateScore() {
        for question in questions {
            if question.isCorrect() {
                total += 1
            }
        }
    }
    
    func reset() {
        gameInProgress = false
        baseNumber = 1
        total = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
