//
//  Candy+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Daan Schutte on 25/11/2022.
//
//

import Foundation
import CoreData


extension Candy {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Candy> {
        return NSFetchRequest<Candy>(entityName: "Candy")
    }

    @NSManaged public var name: String?
    @NSManaged public var origin: Country?

    public var unwrappedName: String {
        name ?? "Unknown Candy"
    }
}

extension Candy : Identifiable {

}
