//
//  CachedUser+CoreDataProperties.swift
//  FriendFace
//
//  Created by Daan Schutte on 10/12/2022.
//
//

import CoreData
import Foundation


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var formattedDate: String?
    @NSManaged public var friends: NSSet?

    var wrappedAbout: String {
        about ?? "Unknown"
    }

    var wrappedAddress: String {
        address ?? "Unknown"
    }

    var wrappedCompany: String {
        company ?? "Unknown"
    }

    var wrappedEmail: String {
        email ?? "Unknown"
    }

    var wrappedName: String {
        name ?? "Unknown"
    }

    var wrappedFormattedDate: String {
        formattedDate ?? "N/A"
    }
    
    // This should be implemented such that it only takes 2/3 letters if the user has >= 3 names
    var initials: String? {
        return name?
            .split(separator: " ")
            .map { $0.first?.description ?? "" }
            .map { $0.uppercased() }
            .joined(separator: "")
    }
    
    public var friendsArray: [CachedFriend] {
        let set = friends as? Set<CachedFriend> ?? []
        return set.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
}

// MARK: Generated accessors for friends
extension CachedUser {

    @objc(addFriendsObject:)
    @NSManaged public func addToFriends(_ value: CachedFriend)

    @objc(removeFriendsObject:)
    @NSManaged public func removeFromFriends(_ value: CachedFriend)

    @objc(addFriends:)
    @NSManaged public func addToFriends(_ values: NSSet)

    @objc(removeFriends:)
    @NSManaged public func removeFromFriends(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
