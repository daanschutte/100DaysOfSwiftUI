//
//  ContentView.swift
//  Flashzilla
//
//  Created by Daan Schutte on 27/12/2022.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.accessibilityDifferentiateWithoutColor) var diffirentiateWithoutColour
    
    var body: some View {
        HStack {
            if diffirentiateWithoutColour {
                Image(systemName: "checkmark.circle")
            }
            
            Text("Success")
        }
        .padding()
        .background(diffirentiateWithoutColour ? .black : .green)
        .foregroundColor(.white)
        .clipShape(Capsule())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
