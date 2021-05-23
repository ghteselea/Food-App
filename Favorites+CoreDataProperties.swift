//
//  Favorites+CoreDataProperties.swift
//  FoodApp
//
//  Created by Alexandra Radu on 23.05.2021.
//
//

import Foundation
import CoreData


extension Favorites {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorites> {
        return NSFetchRequest<Favorites>(entityName: "Favorites")
    }

    @NSManaged public var ids: [Int]?

}

extension Favorites : Identifiable {

}
