//
//  FileManager-Codable.swift
//  Recall
//
//  Created by Daan Schutte on 20/12/2022.
//

import SwiftUI
import Foundation

extension FileManager {
    
    
    func encode<T:Codable>(_ file: String, data: T) {
        if let encoded = try? JSONEncoder().encode(data) {
            let url = FileManager.documentsDirectory.appendingPathComponent(file)
            do {
                try encoded.write(to: url)
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
//        func decode<T: Codable>(_ file: String) -> T? {
//            let url = FileManager.documentsDirectory.appendingPathComponent(file)
//            if let savedItems = try? Data(contentsOf: url) {
//                if let decodedItems = try? JSONDecoder().decode(T.self, from: savedItems) {
//                    return decodedItems
//                }
//            }
//            return nil
//        }
    
    func decode(_ file: String) -> [Person] {
        print("being to decode person")
        let url = FileManager.documentsDirectory.appendingPathComponent(file)
        if let savedItems = try? Data(contentsOf: url) {
            if var decodedPerson = try? JSONDecoder().decode([Person].self, from: savedItems) {
                print("attmept to add image")
                
                let enriched: [Person] = decodedPerson.map {
                    guard let savedImage = loadImageFromDiskWith(fileName: $0.id.uuidString) else {
                        return $0
                    }
                    let image = Image(uiImage: savedImage)
                    print("image was found")
                    return Person(id: $0.id, name: $0.name, image: image)
                }
                    
                
                
                return enriched
            }
        }
        return []
    }
    
    func loadImageFromDiskWith(fileName: String) -> UIImage? {
        let imageUrl = FileManager.documentsDirectory.appendingPathComponent(fileName)
        let image = UIImage(contentsOfFile: imageUrl.path)
        
        if image == nil { print("image was not loaded") }
        
        return image
    }
}
    
//    func decode(_ file: String) -> Person? {
////        let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedImages").absoluteString
////        let imagesPath = FileManager.documentsDirectory.appendingPathComponent("Images")
//
//        let url = FileManager.documentsDirectory.appendingPathComponent(file)
//        if let savedItems = try? Data(contentsOf: url) {
//            if let person = try? JSONDecoder().decode(Person.self, from: savedItems) {
////                for var p in people {
////                    if let savedImage = UIImage(contentsOfFile: imagesPath) {
////                        p.image = Image(uiImage: savedImage)
////                    }
////                }
//                return person
//            }
//        }
//
//        return nil
//    }
//}
