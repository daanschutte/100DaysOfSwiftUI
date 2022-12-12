//
//  ContentView.swift
//  InstaFilter
//
//  Created by Daan Schutte on 10/12/2022.
//

import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var filterIntensity = 0.5
    
    var body: some View {
        NavigationStack {
            VStack{
                ZStack {
                    Rectangle()
                        .fill(.secondary)
                    
                    Text("Tap to select a picture")
                        .foregroundColor(.white)
                        .font(.headline)
                    
                    image?
                        .resizable()
                        .scaledToFit()
                }
                .onTapGesture {
                    // select an image
                }
                
                HStack {
                    Text("Intensity")
                    Slider(value: $filterIntensity)
                }
                
                HStack {
                    Button("Change filter", action: changeFilter)
                    
                    Spacer()
                    
                    Button("Save", action: save)
                }
            }
            .padding([.horizontal, .bottom])
        }
    }
    
    func save() {
        // todo
    }
    
    func changeFilter() {
        // todo
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
