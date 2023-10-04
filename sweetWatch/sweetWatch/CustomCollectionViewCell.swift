//
//  CustomCollectionViewCell.swift
//  sweetWatch
//
//  Created by Jules Duarte on 04/10/2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    @IBOutlet weak var cellLabel: UILabel!
    
    static let identifier = "CustomCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(image : String, title : String){
        self.cellImage.image = UIImage(named: image)
    }

}
