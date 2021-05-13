//
//  ViewController.swift
//  FoodApp
//
//  Created by Alexandra Radu on 28.04.2021.
//

import UIKit
import Firebase

class FoodListViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var arrayOfFoods: [Food] = []
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.register(UINib(nibName: FoodCell.identifier, bundle: nil), forCellReuseIdentifier: FoodCell.identifier)
        tableView.rowHeight = 80.0
        tableView.estimatedRowHeight = 80.0
        
        let database = Database.database(url: "https://foodapp-1a07e-default-rtdb.europe-west1.firebasedatabase.app")
        
        // MARK: - SALVARE DATE IN FIREBASE
        //        let rootRef = database.reference()
        //        let foodsRef = rootRef.child("Spicy pasta")
        ////        let pizzaCategoryRef = foodsRef.child("Nimicfe")
        //////
        //        let pizzaDictionary: [String : Any] = [
        //            "id" : 16,
        //            "type" : "pasta",
        //            "url" : "https://res.cloudinary.com/hbskgqlkj/image/upload/w_500,h_350,c_fit,/v1601975052/atbbkk6okergaoktmzzx.png"
        //            "name" : "Spicy pasta",
        //            "ingrediens": [
        //                "beef",
        //                "ketchup",
        //                "salad",
        //                "parmesan",
        //                "feta cheese",
        ////                "onion",
        //                "mozzarella",
        ////                "pepper"
        //            ],
        //            "extra" : [
        //               "parmesan",
        //                "gorgonzola",
        //                "bacon",
        //                "tomato sauce"
        //            ],
        //            "price": 27
        //        ]
        //        foodsRef.setValue(pizzaDictionary, withCompletionBlock: {
        //            error, dataSnapshot in
        //            if let error = error {
        //                print(error.localizedDescription)
        //                return
        //            }
        //            print(dataSnapshot)
        //        })
        
        //        let pastaCategoryRef = foodsRef.child("pasta")
        //        let pastaRef = pastaCategoryRef.child("Spicy Spaghetti")
        //        let pastaDictionary : [String : Any] = [
        //            "id" : 16,
        //            "name" : "Spicy Spaghetti",
        //            "ingrediens": [
        //                "spaghetti",
        //                "tomatoes",
        //                "spicy tomato sauce",
        //                "olive oil"
        //            ],
        //            "price": 16
        //        ]
        //        pastaRef.setValue(pastaDictionary)
        //
        //        let burgerCategoryRef = foodsRef.child("burgers")
        //        let doubleMeatBurgerRef = burgerCategoryRef.child("Chicken Fillet Burger ")
        //        let burgerDictionary: [String : Any] = [
        //            "name" : "Chicken Fillet Burger ",
        //            "id" : 11,
        //            "ingrediens": [
        //                "chicken meat",
        //                "cheese",
        //                "salad",
        //                "tomato",
        //                "onion",
        //                "pickles",
        //                "ketchup"
        //            ],
        //            "price": 32
        //        ]
        //        doubleMeatBurgerRef.setValue(burgerDictionary)
        
        // <=>
        
        //        let childRef = database.reference(withPath: "foods/pizza&pasta/pizza")
        
        
        // MARK: - CITIRE DATE DIN FIREBASE
        let rootRef = database.reference()
        let foodsRef = rootRef.child("foods")
        //        let pizzaAndPastaRef = foodsRef.child("pizza&pasta")
        //        let pizzaCategoryRef = pizzaAndPastaRef.child("pizza")
        //        pizzaCategoryRef.observe(.value, with: {
        //            dataSnapshot in
        //
        //            let pizzaDictionary = dataSnapshot.value as! [String : AnyObject]
        //            for dictionary in pizzaDictionary {
        //                print("cheia este \(dictionary.key)")
        //                print("valoarea este \(dictionary.value)")
        //            }
        //        })
        
        foodsRef.observe(.value, with: {
            dataSnapshot in
            
            let dictionaries = dataSnapshot.value as! [String : Any]
            for dictionary in dictionaries {
                print("cheia este \(dictionary.key)")
                print("valoarea este \(dictionary.value)")
                
                do {
                    let food = try Food(dictionary: dictionary.value as? [String : Any] ?? [:])
                    print(food.name)
                    self.arrayOfFoods.append(food)
                } catch {
                    print(error.localizedDescription)
                }
            }
            
            self.tableView.reloadData()
        })
        
        // MARK: - UPDATE
        //        let rootRef = database.reference()
        //        let foodsRef = rootRef.child("foods")
        //        let pizzaAndPastaRef = foodsRef.child("pizza&pasta")
        //        let pizzaCategoryRef = pizzaAndPastaRef.child("pizza")
        //        let pizzaRef = pizzaCategoryRef.child("capriciosa")
        //
        //        pizzaRef.updateChildValues(["ceva":"altfel"], withCompletionBlock: {
        //            error, dataSnapshot in
        //
        //            if let error = error {
        //                print(error.localizedDescription)
        //                return
        //            }
        //
        //            print(dataSnapshot)
        //        })
        
        // MARK: - DELETE
        //        let rootRef = database.reference()
        //        let foodsRef = rootRef.child("foods")
        //        let pizzaAndPastaRef = foodsRef.child("pizza&pasta")
        //        let pizzaCategoryRef = pizzaAndPastaRef.child("pizza")
        //        let pizzaRef = pizzaCategoryRef.child("capriciosa")
        //
        //        pizzaRef.removeValue()
        
        // MARK: - DELETE ONE VALUE
        //        let rootRef = database.reference()
        //        let foodsRef = rootRef.child("foods")
        //        let pizzaAndPastaRef = foodsRef.child("pizza&pasta")
        //        let pizzaCategoryRef = pizzaAndPastaRef.child("pizza")
        //        let pizzaRef = pizzaCategoryRef.child("capriciosa")
        //        let priceRef = pizzaRef.child("price")
        //
        //        priceRef.removeValue()
        
        
    }
}

// MARK: - UITableViewDataSource
extension FoodListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfFoods.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.identifier, for: indexPath) as? FoodCell {
            cell.title.text = arrayOfFoods[indexPath.row].name
            cell.img.load(url: arrayOfFoods[indexPath.row].url)
            return cell
        }
        
        return UITableViewCell()
    }
}
