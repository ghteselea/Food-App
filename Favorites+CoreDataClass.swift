//
//  Favorites+CoreDataClass.swift
//  FoodApp
//
//  Created by Alexandra Radu on 23.05.2021.
//
//

import Foundation
import CoreData

@objc(Favorites)
public class Favorites: NSManagedObject {

}

extension Favorites {
    static func saveFavorites(ids: [Int]) {
        let favoritesEntity: Favorites = Favorites(context: PersistenceService.sharedInstance.context)
        
        favoritesEntity.ids = ids
        
        PersistenceService.sharedInstance.saveContext()
    }
    
    static func getFavorites() -> [Int] {
        do {
            let context: NSManagedObjectContext = PersistenceService.sharedInstance.context
            
            let favorites: [Favorites] = try context.fetch(Favorites.fetchRequest()) as? [Favorites] ?? []
            
            guard let favoritesIds = favorites.first else {
                return []
            }
            
            guard let ids = favoritesIds.ids else {
                return []
            }
            
            return ids
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }
    }

}
