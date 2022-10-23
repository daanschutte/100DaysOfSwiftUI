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
}

struct ContentView: View {
    @State private var baseNumber = 1
    @State private var numQuestions = 5
    @State private var numQuestionsAsked = 0
    @State private var questions = [Question]()
      
    @State private var gameInProgress = false
    
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
                        Text("How many questions?")
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
        
        // TODO: Extract into own view
        if gameInProgress {
            VStack {
                // TODO
                
                List(questions, id: \.self.id) { question in
                    HStack {
                        Text(question.problem)
                        // TODO allow user to enter answer
                    }
                }
                
                
                Button("Reset Game") {
                    reset()
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
    
    func startGame() {
        gameInProgress = true
        createQuestionList()
    }
    
    
    func createRandomQuestion(base: Int) -> Question {
        let n = Int.random(in: 1...12)
        return Question(problem: "\(base) x \(n) = ", answer: baseNumber * n)
    }
    
    func createQuestionList() {
        for _ in 0..<numQuestions {
            questions.append(createRandomQuestion(base: baseNumber))
        }
    }
    
    
    func reset() {
        gameInProgress = false
        baseNumber = 1
        numQuestionsAsked = 0
        questions = [Question]()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
