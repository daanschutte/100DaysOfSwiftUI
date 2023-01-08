//
//  Card.swift
//  Flashzilla
//
//  Created by Daan Schutte on 08/01/2023.
//

import Foundation

struct Card {
    let prompt: String
    let answer: String
    
    static let example = Card(prompt: "Who played the 13th Doctor in Doctor Who?", answer: "Jodie Wittaker")
}
