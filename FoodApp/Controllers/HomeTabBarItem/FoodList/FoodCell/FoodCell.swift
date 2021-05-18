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
    
    var isFavourite: Bool = false
    var foodId: Int?
    var favoriteIds: [Int] = []
    
    static let identifier: String = String(describing: FoodCell.self) // FoodCel
    
    @IBAction func changeImageHeart(_ sender: UIButton) {
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
        
        favouritesRef.updateChildValues(["id" : favoriteIds])
    }
    
    func setupHeart() {
        if isFavourite {
            loveBtn.setImage(UIImage(named: "red_heart.png"), for: .normal)
        } else {
            loveBtn.setImage(UIImage(named: "white_heart.png"), for: .normal)
        }
    }
    
}
