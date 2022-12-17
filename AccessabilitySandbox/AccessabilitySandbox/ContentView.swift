//
//  ContentView.swift
//  AccessabilitySandbox
//
//  Created by Daan Schutte on 17/12/2022.
//

import SwiftUI

struct ContentView: View {
    let pictures = [
    "ales-krivec-15949",
    "galina-n-189483",
    "kevin-horstmann-141705",
    "nicolas-tissot-335096",
    ]
    
    let labels = [
    "Tulips",
    "Frozen Tree Buds",
    "Sunflowers",
    "Fireworks"
    ]
    
    @State private var selectedPicture = Int.random(in: 0...3)
    
    var body: some View {
        Image(pictures[selectedPicture])
            .resizable()
            .scaledToFit()
            .onTapGesture {
                selectedPicture = Int.random(in: 0...3)
            }
            .accessibilityLabel(labels[selectedPicture])
            .accessibilityAddTraits(.isButton)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
