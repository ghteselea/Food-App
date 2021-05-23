//
//  FoodEntity+CoreDataProperties.swift
//  FoodApp
//
//  Created by Alexandra Radu on 23.05.2021.
//
//

import Foundation
import CoreData


extension FoodEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FoodEntity> {
        return NSFetchRequest<FoodEntity>(entityName: "FoodEntity")
    }

    @NSManaged public var id: Int16
    @NSManaged public var name: String?
    @NSManaged public var price: Double
    @NSManaged public var url: String?
    @NSManaged public var type: String?
    @NSManaged public var ingredients: [String]?
    @NSManaged public var extra: [String]?

}

extension FoodEntity : Identifiable {

}
