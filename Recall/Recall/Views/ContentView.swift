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
                Button("Add Image") {
                    showingPicker = true
                }
                
                if viewModel.people.count > 0 {
                    List(viewModel.people.sorted()) { person in
                        ListItemView(person: person)
                    }
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
                DetailView(name: $viewModel.name, image: viewModel.image)
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
