//
//  ContentView.swift
//  Recall
//
//  Created by Daan Schutte on 17/12/2022.
//

import CoreImage
import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    @State private var showingPicker = false
    @State private var showingNameInput = false
    
    var body: some View {
        ZStack {
            Text("Add Image")
                .foregroundColor(.blue)
            
            viewModel.image?
                .resizable()
                .scaledToFit()
        }
        .onTapGesture {
            showingPicker = true
            
        }
        .onChange(of: viewModel.inputImage) { _ in
            viewModel.loadImage()
        }
        .onChange(of: viewModel.image) { _ in
            showingNameInput = true
        }
        .sheet(isPresented: $showingPicker) {
            ImagePicker(image: $viewModel.inputImage)
        }
        .sheet(isPresented: $showingNameInput) {
            NameInputView(name: $viewModel.name, image: viewModel.image)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
