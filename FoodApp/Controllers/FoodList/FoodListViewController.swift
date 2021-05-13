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
        
        // MARK: - CITIRE DATE DIN FIREBASE
        let database = FirebaseManager.sharedInstance.database
        let rootRef = database.reference()
        let foodsRef = rootRef.child("foods")
        
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
    }
}

// MARK: - UITableViewDataSource
extension FoodListViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfFoods.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.identifier, for: indexPath) as? FoodCell {
            cell.titleLbl.text = arrayOfFoods[indexPath.row].name
            cell.imgView.load(url: arrayOfFoods[indexPath.row].url)
            return cell
        }
        
        return UITableViewCell()
    }
}
