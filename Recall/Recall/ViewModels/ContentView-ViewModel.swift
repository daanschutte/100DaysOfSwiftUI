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
        
        @Published var people: [Person]
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPeople")
        let imagesPath = FileManager.documentsDirectory
        
        init() {
            self.image = nil
            self.inputImage = nil
            
            _name = Published(initialValue: "")
            
            do {
                let data = try Data(contentsOf: savePath)
                people = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                people = []
            }
            
            
            
            let enriched: [Person] = people.map {
                guard let savedImage = loadImageFromDiskWith(fileName: $0.id.uuidString) else {
                    return $0
                }
                let image = Image(uiImage: savedImage)
                print("image was found")
                return Person(id: $0.id, name: $0.name, image: image)
            }
            
            
            
            self.people = enriched
            
//            for var p in people {
//                guard let loadedImage = loadImageFromDiskWith(fileName: p.id.uuidString) else {
//                    print("Failed to load image from file")
//                    return
//                }
//
//                print("try to assign uimage")
//
//                p.image = Image(uiImage: loadedImage)
//            }
        }
        
        func loadImageFromDiskWith(fileName: String) -> UIImage? {
            let imageUrl = FileManager.documentsDirectory.appendingPathComponent(fileName)
            let image = UIImage(contentsOfFile: imageUrl.path)
            
            if image == nil { print("image was not loaded") }
            
            return image
        }
        
        func loadImage() {
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
        }
        
        func addImage() {
            guard let personImage = image else { return }
            let newPerson = Person(id: UUID(), name: name, image: personImage)
            people.append(newPerson)
            
            save()
            saveImage(filename: newPerson.id.uuidString)
            
            image = nil
            name = ""
        }
        
        func save() {
            do {
                let data = try JSONEncoder().encode(people)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Could not save data")
            }
        }
        
        func saveImage(filename: String) {
            guard let inputImage = inputImage else { return }
            let imageSaver = ImageSaver()
            imageSaver.successHandler = { print("Image saved") }
            imageSaver.errorHanfler = { print("There was an error saving the image: \($0.localizedDescription)") }
            
            let url = imagesPath.appendingPathComponent(filename)
            if let jpegData = inputImage.jpegData(compressionQuality: 0.8) {
                do {
                    try jpegData.write(to: url, options: [.atomicWrite, .completeFileProtection])
                } catch {
                    print("Error saving image: \(error.localizedDescription)")
                }
            }
        }
    }
}
