//
//  UserEntity+CoreDataClass.swift
//  FoodApp
//
//  Created by Alexandra Radu on 30.05.2021.
//
//

import Foundation
import CoreData


public class UserEntity: NSManagedObject {

}

extension UserEntity {
    static func saveLoggedUser(isAnonymous: Bool, isEmailVerified: Bool, providerID: String, uid: String) {
        let currentUser: UserEntity = UserEntity(context: PersistenceService.sharedInstance.context)
        
        currentUser.isAnonymous = isAnonymous
        currentUser.isEmailVerified = isEmailVerified
        currentUser.providerID = providerID
        currentUser.uid = uid
        
        PersistenceService.sharedInstance.saveContext()
    }
    
    static func getLoggedUer() -> UserEntity? {
        do {
            let context: NSManagedObjectContext = PersistenceService.sharedInstance.context
            
            let users: [UserEntity] = try context.fetch(UserEntity.fetchRequest()) as? [UserEntity] ?? []
            
            guard let user = users.first else {
                return nil
            }
            
            return user
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return nil
        }
    }
}


