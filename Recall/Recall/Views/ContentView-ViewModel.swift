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
        
        @Published var images = [String: Image]()
        
        init() {
            self.image = nil
            self.inputImage = nil
            
            _name = Published(initialValue: "")
            
        }
        
        func loadImage() {
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
        }
    }
}
