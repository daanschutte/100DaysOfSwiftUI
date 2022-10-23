//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Daan Schutte on 19/10/2022.
//

import SwiftUI

struct ContentView: View {
    
    let motto1 = Text("Draco dormiens")
    let motto2 = Text("Munquam titillandus")
    
    var body: some View {
        VStack {
            motto1.foregroundColor(.red)
            motto2.foregroundColor(.blue)
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
