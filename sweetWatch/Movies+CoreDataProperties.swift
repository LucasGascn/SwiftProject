//
//  Movies+CoreDataProperties.swift
//  sweetWatch
//
//  Created by Jules Duarte on 04/10/2023.
//
//

import Foundation
import CoreData


extension Movies {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Movies> {
        return NSFetchRequest<Movies>(entityName: "Movies")
    }

    @NSManaged public var name: String?
    @NSManaged public var image: String?
    @NSManaged public var synopsis: String?
    @NSManaged public var rating: Float
    @NSManaged public var id: Int64
    @NSManaged public var actors: NSSet?
    @NSManaged public var users: Users?

}

// MARK: Generated accessors for actors
extension Movies {

    @objc(addActorsObject:)
    @NSManaged public func addToActors(_ value: Actors)

    @objc(removeActorsObject:)
    @NSManaged public func removeFromActors(_ value: Actors)

    @objc(addActors:)
    @NSManaged public func addToActors(_ values: NSSet)

    @objc(removeActors:)
    @NSManaged public func removeFromActors(_ values: NSSet)

}

extension Movies : Identifiable {

}
