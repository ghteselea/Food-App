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
    
    static let identifier: String = String(describing: FoodCell.self) // FoodCel
    
    @IBAction func changeImageHeart(_ sender: UIButton) {
        if isFavourite {
            isFavourite = false
        } else {
            isFavourite = true
        }
        
        setupHeart()
    }
    
    func setupHeart() {
        if isFavourite {
            loveBtn.setImage(UIImage(named: "red_heart.png"), for: .normal)
        } else {
            loveBtn.setImage(UIImage(named: "white_heart.png"), for: .normal)
        }
    }
    
}
