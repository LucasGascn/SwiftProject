//
//  Series+CoreDataProperties.swift
//  sweetWatch
//
//  Created by Jules Duarte on 04/10/2023.
//
//

import Foundation
import CoreData


extension Series {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Series> {
        return NSFetchRequest<Series>(entityName: "Series")
    }

    @NSManaged public var image: String?
    @NSManaged public var name: String?
    @NSManaged public var rating: Float
    @NSManaged public var synopsis: String?
    @NSManaged public var id: Int64
    @NSManaged public var actors: NSSet?
    @NSManaged public var users: NSSet?

}

// MARK: Generated accessors for actors
extension Series {

    @objc(addActorsObject:)
    @NSManaged public func addToActors(_ value: Actors)

    @objc(removeActorsObject:)
    @NSManaged public func removeFromActors(_ value: Actors)

    @objc(addActors:)
    @NSManaged public func addToActors(_ values: NSSet)

    @objc(removeActors:)
    @NSManaged public func removeFromActors(_ values: NSSet)

}

// MARK: Generated accessors for users
extension Series {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: Users)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: Users)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}

extension Series : Identifiable {

}
