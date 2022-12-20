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
        
        @Published private(set) var people: [Person]
        
        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedPeople")
        let imagesPath = FileManager.documentsDirectory
        
        init() {
            image = nil
            inputImage = nil
            
            _name = Published(initialValue: "")
            
            do {
                let data = try Data(contentsOf: savePath)
                people = try JSONDecoder().decode([Person].self, from: data)
            } catch {
                people = []
            }
            
            people = people.map { addUserImageFromDisk(person: $0) }
        }
        
        private func addUserImageFromDisk(person: Person) -> Person {
            let imageUrl = FileManager.documentsDirectory.appendingPathComponent(person.id.uuidString)
            guard let savedImage = UIImage(contentsOfFile: imageUrl.path) else {
                print("Failed to locate image for user \(person.id.uuidString)")
                return person
            }
            let image = Image(uiImage: savedImage)
            return Person(id: person.id, name: person.name, image: image)
        }
        
        
        func loadImage() {
            guard let inputImage = inputImage else { return }
            image = Image(uiImage: inputImage)
        }
        
        func addPerson() {
            guard let newImage = image else { return }
            let newPerson = Person(id: UUID(), name: name, image: newImage)
            people.append(newPerson)
            
            savePerson(id: newPerson.id.uuidString)
            
            image = nil
            name = ""
        }
        
        func savePerson(id: String) {
            do {
                let data = try JSONEncoder().encode(people)
                try data.write(to: savePath, options: [.atomicWrite, .completeFileProtection])
            } catch {
                print("Could not save data")
            }
            
            saveImage(filename: id)
        }
        
        private func saveImage(filename: String) {
            let url = imagesPath.appendingPathComponent(filename)
            guard let inputImage = inputImage else { return }
            if let jpegData = inputImage.jpegData(compressionQuality: 0.8) {
                try? jpegData.write(to: url, options: [.atomicWrite, .completeFileProtection])
            }
        }
    }
}
