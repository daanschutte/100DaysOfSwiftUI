//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Daan Schutte on 20/10/2022.
//

import SwiftUI

struct LargeEmoji: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 80))
    }
}

struct LargerEmoji: ViewModifier {
    func body(content: Content) -> some View {
        content.font(.system(size: 125))
    }
}

extension View {
    func largeEmoji() -> some View {
        modifier(LargeEmoji())
    }
    
    func largerEmoji() -> some View {
        modifier(LargerEmoji())
    }
}

struct ContentView: View {
    @State private var systemMove = Int.random(in: 0..<3)
    @State private var userMove = ""
    @State private var shouldWin = Bool.random()
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingResult = false
    @State private var showingGameOver = false
    
    @State private var score = 0
    @State private var roundsPlayed = 0
    
    @State private var statusColor = Color.accentColor
    
    let moves = ["👊", "🤚", "✌️"]
    
    let maxRounds = 10
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: statusColor, location: 0.3),
                .init(color: .black, location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                Section {
                    Text("You should...")
                        .font(.headline.bold())
                        .foregroundColor(.black)
                    Text(shouldWin ? "Win!" : "Lose!")
                        .font(.largeTitle.weight(.semibold))
                        .foregroundColor(.white)
                }
                
                Spacer()
                Section {
                    Text(moves[systemMove]).largerEmoji()
                }
                
                Spacer()
                Section {
                    HStack {
                        ForEach(moves, id: \.self) { move in
                            Spacer()
                            Button(move) {
                                userMove = move
                                submitAnswer()
                            }.largeEmoji()
                            Spacer()
                        }
                    }
                    .padding()
                }
                
            }.alert(alertTitle, isPresented: $showingResult) {
                Button("Continue", action: nextRound)
            } message: {
                Text(alertMessage)
            }.alert(alertTitle, isPresented: $showingGameOver) {
                Button("Restart", action: reset)
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func submitAnswer() {
        let sysMove = moves[systemMove]
        if shouldWin == playerWins() && sysMove != userMove {
            alertTitle = "Correct"
            alertMessage = "\(shouldWin ? userMove : sysMove) beats \(shouldWin ? sysMove : userMove)"
            score += 1
            statusColor = .green
        } else {
            alertTitle = "Bad luck"
            alertMessage = "\(userMove) does not \(shouldWin ? "beat" : "lose to") \(sysMove)"
            statusColor = .red
        }
        
        showingResult = true
    }
    
    func playerWins() -> Bool {
        switch moves[systemMove] {
        case "👊":
            return userMove == "🤚"
        case "🤚":
            return userMove == "✌️"
        case "✌️":
            return userMove == "👊"
        default:
            return false
        }
    }
    
    func nextRound() {
        statusColor = .accentColor
        shouldWin = Bool.random()
        systemMove = Int.random(in: 0..<3)
        roundsPlayed += 1

        if roundsPlayed >= maxRounds {
            alertTitle = "Game Over"
            alertMessage = "You were correct \(score)/\(maxRounds) times."
            showingGameOver = true
        }
    }
    
    func reset() {
        systemMove = Int.random(in: 0..<3)
        shouldWin = Bool.random()
        userMove = ""
        alertTitle = ""
        alertMessage = ""
        score = 0
        roundsPlayed = 0
        statusColor = .accentColor
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
