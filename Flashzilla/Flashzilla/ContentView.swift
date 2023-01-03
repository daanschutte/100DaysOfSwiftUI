//
//  ContentView.swift
//  Flashzilla
//
//  Created by Daan Schutte on 27/12/2022.
//

import CoreHaptics
import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.blue)
                .frame(width: 300, height: 300)
                .onTapGesture {
                    print("Rectangle tapped!")
                }
            
            Circle()
                .fill(.red)
                .frame(width: 300, height: 300)
//                .contentShape(Rectangle()) // use whole frame of circle
                .onTapGesture {
                    print("Circle tapped!")
                }
//                .allowsHitTesting(false) // tap through the circle
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
