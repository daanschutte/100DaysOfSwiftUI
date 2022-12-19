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
                    Button("Add Image") {
                        showingPicker = true
                    }
                    .foregroundColor(.blue)
                }
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingPicker = true
                    } label: {
                        Image(systemName: "plus")
                            .padding(.horizontal)
                    }
                }
            }
            .onChange(of: viewModel.inputImage) { _ in
                viewModel.loadImage()
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
