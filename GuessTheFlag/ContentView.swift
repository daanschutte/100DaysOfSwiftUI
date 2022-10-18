//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Daan Schutte on 18/10/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var attempts = 0
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    @State private var resultMessage = ""
    @State private var score = 0
    @State private var scoreTitle = ""
    @State private var showingGameOver = false
    @State private var showingScore = false
    
    let maxAttempts = 8
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                            .font(.subheadline.weight(.heavy))
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(Capsule())
                                .shadow(radius: 5)
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                
                
                Spacer()
                Spacer()
                
                Text("Score: \(score)")
                    .foregroundColor(.white)
                    .font(.title.bold())
                
                Spacer()
            }.padding()
            
        }.alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text(resultMessage)
        }
        .alert("Game Over", isPresented: $showingGameOver) {
            Button("Reset", action: reset)
        } message: {
            Text("Your final score was \(score)/8")
        }
    }
    
    func flagTapped(_ number: Int) {
        let country = countries[number]
        if number == correctAnswer {
            score += 1
            scoreTitle = "Correct"
            resultMessage = "Score: \(score)"
        } else {
            scoreTitle = "Wrong!"
            resultMessage = "That was the flag for \(country).\nScore: \(score)"
        }
        
        showingScore = true

        attempts += 1
        if attempts >= maxAttempts {
            showingGameOver = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func reset() {
        score = 0
        attempts = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
