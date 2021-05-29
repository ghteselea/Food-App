//
//  TableViewCell.swift
//  FoodApp
//
//  Created by Alexandra Radu on 13.05.2021.
//

import UIKit

class FoodCell: UITableViewCell {

    @IBOutlet weak var loveBtn: UIButton!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    
    var viewController: UIViewController?
    var isFavourite: Bool = false
    var foodId: Int?
    var favoriteIds: [Int] = []
    var isFavoriteCell: Bool = false
    
    static let identifier: String = String(describing: FoodCell.self) // "FoodCell"
    
    @IBAction func changeImageHeart(_ sender: UIButton) {
        
        guard let viewController = viewController else {
            return
        }
        
        guard !isFavoriteCell else {
            AlertManager.shared.showAlertManager(vc: viewController, message: "You can only change the status from the home screen", handler: {})
            return
        }
        
        let database = FirebaseManager.sharedInstance.database
        let rootRef = database.reference()
        let favouritesRef = rootRef.child("favourites")
        
        if isFavourite {
            // stergi elementul
            for(index, element) in favoriteIds.enumerated() {
                if element == foodId {
                    favoriteIds.remove(at: index)
                    break
                }
            }
        } else {
            guard let foodId = foodId else {
                return
            }
            favoriteIds.append(foodId)
        }
        
        favouritesRef.updateChildValues(["id" : favoriteIds]) { (error, _) in
            guard let error = error else {
                return
            }
            
            guard let viewController = self.viewController else {
                print("ViewController not existing")
                return
            }
            
            AlertManager.shared.showAlertManager(vc: viewController, message: error.localizedDescription, handler: {})
        }
    }
    
    func setupHeart() {
        if isFavourite {
            loveBtn.setImage(UIImage(named: "red_heart.png"), for: .normal)
        } else {
            loveBtn.setImage(UIImage(named: "white_heart.png"), for: .normal)
        }
    }
    
}
