//
//  UserEntity+CoreDataProperties.swift
//  FoodApp
//
//  Created by Alexandra Radu on 30.05.2021.
//
//

import Foundation
import CoreData


extension UserEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserEntity> {
        return NSFetchRequest<UserEntity>(entityName: "UserEntity")
    }

    @NSManaged public var isAnonymous: Bool
    @NSManaged public var isEmailVerified: Bool
    @NSManaged public var providerID: String?
    @NSManaged public var uid: String?

}

extension UserEntity : Identifiable {

}
