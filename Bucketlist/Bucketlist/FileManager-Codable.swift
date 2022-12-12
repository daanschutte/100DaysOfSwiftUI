//
//  FileLoader.swift
//  Bucketlist
//
//  Created by Daan Schutte on 12/12/2022.
//

import Foundation


extension FileManager {
    func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    func encode<T:Codable>(_ file: String, data: T) {
        if let encoded = try? JSONEncoder().encode(data) {
            let url = getDocumentsDirectory().appendingPathComponent(file)
            do {
                try encoded.write(to: url)
            } catch {
                print(error.localizedDescription)
            }
        }
    }

    func decode<T: Codable>(_ file: String) -> T? {
        let url = getDocumentsDirectory().appendingPathComponent(file)
        if let savedItems = try? Data(contentsOf: url) {
            if let decodedItems = try? JSONDecoder().decode(T.self, from: savedItems) {
                return decodedItems
            }
        }
        return nil
    }
}
