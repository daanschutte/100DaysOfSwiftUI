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

extension Question {
    func createTimesTable(base: Int) -> [Question] {
        var questions = [Question]()
        for n in 1..<12 {
            let question = Question(problem: "\(base) x \(n) = ?", answer: base * n)
            questions.append(question)
        }
        return questions
    }
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
            .padding()
        }
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
