//
//  FavoritesViewController.swift
//  FoodApp
//
//  Created by Alexandra Radu on 29.05.2021.
//

import UIKit

class FavoritesViewController: UIViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Variables
    var favoriteFoods: [Food] = []
    
    // MARK: - Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupScreen()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getFavoriteFoods()
    }
    
    // MARK: - Navigation
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) { }
    
    // MARK: - IBActions
    
    // MARK: - VC Methods
    func setupScreen() {
        tableView.dataSource = self
        tableView.register(UINib(nibName: FoodCell.identifier, bundle: nil), forCellReuseIdentifier: FoodCell.identifier)
        tableView.rowHeight = 80.0
        tableView.estimatedRowHeight = 80.0
    }
    
    func getFavoriteFoods() {
        let allFoods: [Food] = FoodEntity.getAllFoods()
        let favoritesIds: [Int] = Favorites.getFavorites()
        
        // 1
//        for food in allFoods {
//            if favoritesIds.contains(food.id) {
//                favoriteFoods.append(food)
//            }
//        }
        
        // 2
//        for food in allFoods where favoritesIds.contains(food.id) {
//            favoriteFoods.append(food)
//        }
        
        // 3
//        favoriteFoods = allFoods.filter({ (food) -> Bool in
//            return favoritesIds.contains(food.id)
//        })
        
        // 3 simplificat
        favoriteFoods = allFoods.filter { favoritesIds.contains($0.id) }
        tableView.reloadData()
    }
}

// MARK: - UITableViewDataSource
extension FavoritesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoriteFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FoodCell.identifier, for: indexPath) as? FoodCell else {
            return UITableViewCell()
        }
        
        let currentFood: Food = favoriteFoods[indexPath.row]
        
        cell.titleLbl.text = currentFood.name
        cell.imgView.load(url: currentFood.url)
        
        cell.isFavourite = true // we select all favorites from the beginning
                    
        cell.foodId = currentFood.id
        cell.viewController = self
        
        // flag to know that if the cell is from FavoritesViewController
        cell.isFavoriteCell = true
        
        cell.setupHeart()
        
        return cell
    }
}
