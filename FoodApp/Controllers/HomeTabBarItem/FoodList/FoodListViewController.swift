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
    var arrayOfFavourites: [Int] = []
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.register(UINib(nibName: FoodCell.identifier, bundle: nil), forCellReuseIdentifier: FoodCell.identifier)
        tableView.rowHeight = 80.0
        tableView.estimatedRowHeight = 80.0
        
        checkIfUserIsStillLoggedIn()
        getFoods()
        getFavorites()
    }
    
    func checkIfUserIsStillLoggedIn() {
        Auth.auth().addStateDidChangeListener { (auth, user) in
            guard let user = user else {
                PersistenceService.sharedInstance.deleteEntity(named: String(describing: UserEntity.self))
                PersistenceService.sharedInstance.deleteEntity(named: String(describing: Favorites.self))
                
                self.arrayOfFavourites.removeAll()
                self.tableView.reloadData()
                
                return
            }
            
            UserEntity.saveLoggedUser(isAnonymous: user.isAnonymous, isEmailVerified: user.isEmailVerified, providerID: user.providerID, uid: user.uid)
            self.getFavorites()
        }
    }
    
    func getFoods() {
        let database = FirebaseManager.sharedInstance.database
        let rootRef = database.reference()
        
        let foodsRef = rootRef.child("foods")
        foodsRef.observe(.value, with: {
            dataSnapshot in
            
            PersistenceService.sharedInstance.deleteEntity(named: "FoodEntity")
            
            let dictionaries = dataSnapshot.value as! [String : Any]
            for dictionary in dictionaries {
                print("cheia este \(dictionary.key)")
                print("valoarea este \(dictionary.value)")
                
                FoodEntity.saveFood(from: dictionary.value as? [String : Any] ?? [:])
            }
            
            self.arrayOfFoods = FoodEntity.getAllFoods()
            
            self.arrayOfFoods.sort(by: {$0.id < $1.id})
            self.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
            
            self.arrayOfFoods = FoodEntity.getAllFoods()
        }
    }
    
    func getFavorites() {
        
        guard let user = UserEntity.getLoggedUer() else {
            arrayOfFavourites.removeAll()
            tableView.reloadData()
            return
        }
        
        guard let uid = user.uid else {
            arrayOfFavourites.removeAll()
            tableView.reloadData()
            return
        }
        
        let database = FirebaseManager.sharedInstance.database
        let rootRef = database.reference()
        
        let usersRef = rootRef.child("users")
        
        let currentUser = usersRef.child("\(uid)")
        let favouritesRef = currentUser.child("favourites")
        
        let idsRef = favouritesRef.child("id")
        idsRef.observe(.value, with: {
            dataSnapshot in
            
            PersistenceService.sharedInstance.deleteEntity(named: "Favorites")
            self.arrayOfFavourites.removeAll()
            
            let array = dataSnapshot.value as? [Int] ?? []
            Favorites.saveFavorites(ids: array)
            
            self.arrayOfFavourites = Favorites.getFavorites()
            
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
            
            let currentFood: Food = arrayOfFoods[indexPath.row]
            
            cell.titleLbl.text = currentFood.name
            cell.imgView.load(url: currentFood.url)
            
            if arrayOfFavourites.contains(currentFood.id) {
                cell.isFavourite = true
            } else {
                cell.isFavourite = false
            }
                        
            cell.foodId = currentFood.id
            
            cell.favoriteIds = arrayOfFavourites
            
            cell.viewController = self
            
            cell.setupHeart()
            
            return cell
        }
        
        return UITableViewCell()
    }
}
