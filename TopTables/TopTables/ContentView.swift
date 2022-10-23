//
//  ContentView.swift
//  TopTables
//
//  Created by Daan Schutte on 23/10/2022.
//

import SwiftUI

struct Question {
    let problem: String
    let answer: Int
}

struct ContentView: View {
    @State private var baseNumber = 1
    @State private var numQuestions = 5
    @State private var numQuestionsAsked = 0
    @State private var questions = [Question]()
    
    var body: some View {
        VStack {
            //            Stepper("Which times table would you like to test?", value: $baseNumber)
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
    
    func startGame() {
        createTimesTable()
    }
    
    
    func createTimesTable() {
        for n in 1..<12 {
            let question = Question(problem: "\(baseNumber) x \(n) = ?", answer: baseNumber * n)
            questions.append(question)
        }
    }
    
    func createQuestionList() {
        
    }
    
    
    func reset() {
        baseNumber = 1
        numQuestions = 5
        numQuestionsAsked = 0
        questions = [Question]()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
