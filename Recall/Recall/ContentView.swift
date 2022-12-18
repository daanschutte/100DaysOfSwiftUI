//
//  ContentView.swift
//  Recall
//
//  Created by Daan Schutte on 17/12/2022.
//

import CoreImage
import SwiftUI

struct ContentView: View {
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    @State private var showingPicker = false
    
    var body: some View {
        ZStack {
            Text("Add Image")
                .foregroundColor(.blue)
            
            image?
                .resizable()
                .scaledToFit()
        }
        .onTapGesture {
            showingPicker = true
            
        }
        .sheet(isPresented: $showingPicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { _ in
            loadImage()
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
