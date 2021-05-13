//
//  TableViewCell.swift
//  FoodApp
//
//  Created by Alexandra Radu on 13.05.2021.
//

import UIKit

class FoodCell: UITableViewCell {

    @IBOutlet weak var img: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    static let identifier: String = String(describing: FoodCell.self) // FoodCell
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
