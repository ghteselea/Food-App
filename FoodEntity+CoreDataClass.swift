//
//  FoodEntity+CoreDataClass.swift
//  FoodApp
//
//  Created by Alexandra Radu on 23.05.2021.
//
//

import Foundation
import CoreData

@objc(FoodEntity)
public class FoodEntity: NSManagedObject {

}

extension FoodEntity {
    static func saveFood(from dictionary: [String: Any]) {
        do {
            let foodInstance: Food = try Food(dictionary: dictionary)
            
            let foodEntity: FoodEntity = FoodEntity(context: PersistenceService.sharedInstance.context)
            foodEntity.id = Int16(foodInstance.id)
            foodEntity.extra = foodInstance.extra
            foodEntity.ingredients = foodInstance.ingrediens
            foodEntity.name = foodInstance.name
            foodEntity.price = foodInstance.price
            foodEntity.type = foodInstance.type
            foodEntity.url = foodInstance.url
            
            PersistenceService.sharedInstance.saveContext()
        } catch {
            print("Not able to create a Food item")
        }
    }
    
    func convertFoodEntityToFood() -> Food {
        let food = Food(foodEntity: self)
        return food
    }
    
    static func getAllFoods() -> [Food] {
        do {
            let context: NSManagedObjectContext = PersistenceService.sharedInstance.context
            
            let foods: [FoodEntity] = try context.fetch(FoodEntity.fetchRequest()) as? [FoodEntity] ?? []
            return foods.map { $0.convertFoodEntityToFood() }
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
            return []
        }

    }
}
