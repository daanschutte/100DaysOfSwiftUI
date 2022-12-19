//
//  ContentView-ViewModel.swift
//  Recall
//
//  Created by Daan Schutte on 18/12/2022.
//

import Foundation
import SwiftUI

extension ContentView {
    @MainActor class ViewModel: ObservableObject {
        @Published var image: Image?
        @Published var inputImage: UIImage?
        @Published var name: String
        
        @Published var people = [Person]()
        
        init() {
            self.image = nil
            self.inputImage = nil
            
            _name = Published(initialValue: "")
        }
        
        func loadImage() {
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
        }
        
        func saveImage() {
            guard let personImage = image else { return }
            let newPerson = Person(name: name, image: personImage)
            people.append(newPerson)
            
            image = nil
            name = ""
        }
        
        // TODO: persist data, load on start
    }
}
