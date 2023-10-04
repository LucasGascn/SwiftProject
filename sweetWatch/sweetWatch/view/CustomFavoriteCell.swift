//
//  CustomFavoriteCell.swift
//  sweetWatch
//
//  Created by coding on 04/10/2023.
//

import UIKit

class CustomFavoriteCell: UITableViewCell {

    @IBOutlet weak var favoriteView: UIView!
    @IBOutlet weak var favoriteImageView: UIImageView!
    @IBOutlet weak var favoriteTitleView: UILabel!
    @IBOutlet weak var favoriteResumeView: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
