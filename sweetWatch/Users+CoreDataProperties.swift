//
//  Users+CoreDataProperties.swift
//  sweetWatch
//
//  Created by Jules Duarte on 04/10/2023.
//
//

import Foundation
import CoreData


extension Users {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Users> {
        return NSFetchRequest<Users>(entityName: "Users")
    }

    @NSManaged public var name: String?
    @NSManaged public var password: String?
    @NSManaged public var movies: NSSet?
    @NSManaged public var series: NSSet?

}

// MARK: Generated accessors for movies
extension Users {

    @objc(addMoviesObject:)
    @NSManaged public func addToMovies(_ value: Movies)

    @objc(removeMoviesObject:)
    @NSManaged public func removeFromMovies(_ value: Movies)

    @objc(addMovies:)
    @NSManaged public func addToMovies(_ values: NSSet)

    @objc(removeMovies:)
    @NSManaged public func removeFromMovies(_ values: NSSet)

}

// MARK: Generated accessors for series
extension Users {

    @objc(addSeriesObject:)
    @NSManaged public func addToSeries(_ value: Series)

    @objc(removeSeriesObject:)
    @NSManaged public func removeFromSeries(_ value: Series)

    @objc(addSeries:)
    @NSManaged public func addToSeries(_ values: NSSet)

    @objc(removeSeries:)
    @NSManaged public func removeFromSeries(_ values: NSSet)

}

extension Users : Identifiable {

}
