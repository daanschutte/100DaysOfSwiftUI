//
//  Bundle-Decodable.swift
//  Repeat
//
//  Created by Daan Schutte on 11/11/2022.
//

import Foundation

extension Bundle {
    func decode(_ file: String) -> Activities {
        guard let url = self.url(forResource: file, withExtension: nil) else {
            fatalError("Failed to locate \(file) in Bundle.")
        }
        
        guard let data = try? Data(contentsOf: url) else {
            fatalError("Failed to open \(file) from Bundle.")
        }
        
        let decoder = JSONDecoder()
        // TODO: decoding strategy?
        
        guard let loaded = try? decoder.decode(Activities.self, from: data) else {
            fatalError("Failed to decode \(file) from Bundle.")
        }
        
        return loaded
    }
}
