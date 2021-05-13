//
//  FirebaseManager.swift
//  FoodApp
//
//  Created by Alexandra Radu on 13.05.2021.
//

import Foundation
import Firebase

class FirebaseManager {
    private init() { }
    static let sharedInstance = FirebaseManager()
    
    let database = Database.database(url: "https://foodapp-1a07e-default-rtdb.europe-west1.firebasedatabase.app")
    
    // MARK: - SALVARE DATE IN FIREBASE
    func saveData() {
        let rootRef = database.reference()
        let foodsRef = rootRef.child("Paste turbate")
        let dictionary: [String : Any] = [
            "id" : 16,
            "type" : "pasta",
            "url" : "https://res.cloudinary.com/hbskgqlkj/image/upload/w_500,h_350,c_fit,/v1601975052/atbbkk6okergaoktmzzx.png",
            "name" : "Paste Turbate",
            "ingrediens": [
                "beef",
                "ketchup",
                "salad",
                "parmesan",
                "feta cheese",
                //                "onion",
                "mozzarella",
                //                "pepper"
            ],
            "extra" : [
                "parmesan",
                "gorgonzola",
                "bacon",
                "tomato sauce"
            ],
            "price": 27
        ]
        foodsRef.setValue(dictionary, withCompletionBlock: {
            error, dataSnapshot in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print(dataSnapshot)
        })
        
        let pastaCategoryRef = foodsRef.child("pasta")
        let pastaRef = pastaCategoryRef.child("Spicy Spaghetti")
        let pastaDictionary : [String : Any] = [
            "id" : 16,
            "name" : "Spicy Spaghetti",
            "ingrediens": [
                "spaghetti",
                "tomatoes",
                "spicy tomato sauce",
                "olive oil"
            ],
            "price": 16
        ]
        pastaRef.setValue(pastaDictionary)
        
        let burgerCategoryRef = foodsRef.child("burgers")
        let doubleMeatBurgerRef = burgerCategoryRef.child("Burger Turbat")
        let burgerDictionary: [String : Any] = [
            "name" : "Burger Turbat",
            "id" : 11,
            "ingrediens": [
                "chicken meat",
                "cheese",
                "salad",
                "tomato",
                "onion",
                "pickles",
                "ketchup"
            ],
            "price": 32
        ]
        doubleMeatBurgerRef.setValue(burgerDictionary)
    }
    
    func readData() {
        let rootRef = database.reference()
        let foodsRef = rootRef.child("foods")
        let pizzaAndPastaRef = foodsRef.child("pizza&pasta")
        let pizzaCategoryRef = pizzaAndPastaRef.child("pizza")
        pizzaCategoryRef.observe(.value, with: {
            dataSnapshot in
            
            let pizzaDictionary = dataSnapshot.value as! [String : AnyObject]
            for dictionary in pizzaDictionary {
                print("cheia este \(dictionary.key)")
                print("valoarea este \(dictionary.value)")
            }
        })
    }

    // MARK: - UPDATE
    func updateData() {
        let rootRef = database.reference()
        let foodsRef = rootRef.child("foods")
        let pizzaAndPastaRef = foodsRef.child("pizza&pasta")
        let pizzaCategoryRef = pizzaAndPastaRef.child("pizza")
        let pizzaRef = pizzaCategoryRef.child("capriciosa")
        
        pizzaRef.updateChildValues(["ceva":"altfel"], withCompletionBlock: {
            error, dataSnapshot in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            print(dataSnapshot)
        })
    }
    
    // MARK: - DELETE
    func delete() {
        let rootRef = database.reference()
        let foodsRef = rootRef.child("foods")
        let pizzaAndPastaRef = foodsRef.child("pizza&pasta")
        let pizzaCategoryRef = pizzaAndPastaRef.child("pizza")
        let pizzaRef = pizzaCategoryRef.child("capriciosa")
        
        pizzaRef.removeValue()
    }
    
    // MARK: - DELETE ONE VALUE
    func deleteOneValue() {
        let rootRef = database.reference()
        let foodsRef = rootRef.child("foods")
        let pizzaAndPastaRef = foodsRef.child("pizza&pasta")
        let pizzaCategoryRef = pizzaAndPastaRef.child("pizza")
        let pizzaRef = pizzaCategoryRef.child("capriciosa")
        let priceRef = pizzaRef.child("price")
        
        priceRef.removeValue()
    }
}
