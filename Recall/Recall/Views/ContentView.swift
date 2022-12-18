//
//  ContentView.swift
//  Recall
//
//  Created by Daan Schutte on 17/12/2022.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = ViewModel()
    
    @State private var showingPicker = false
    @State private var showingNameInput = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                if viewModel.images.count > 0 {
                    List{
                        ForEach(Array(viewModel.images), id: \.key) { name, image in
                            HStack {
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 60, height: 60)
                                
                                Text(name)
                            }
                        }
                    }
                } else {
                    Text("Add Image")
                        .foregroundColor(.blue)
                    // TODO: once this is removed we need some way to keep adding people
                }
            }
            // TODO: review these onEvents
            .onTapGesture {
                showingPicker = true
            }
            .onChange(of: viewModel.inputImage) { _ in
                viewModel.loadImage()
            }
            .onChange(of: viewModel.image) { _ in
                // TODO: this is breaking the picker when it gets set to nil again on saveImage
                showingNameInput = true
            }
            .sheet(isPresented: $showingPicker) {
                ImagePicker(image: $viewModel.inputImage)
            }
            .sheet(isPresented: $showingNameInput) {
                NameInputView(name: $viewModel.name, image: viewModel.image)
                    .onDisappear {
                        viewModel.saveImage()
                    }
            }
            .navigationTitle("Recaller")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
