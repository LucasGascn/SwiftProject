//
//  CustomCollectionViewCell.swift
//  sweetWatch
//
//  Created by Jules Duarte on 04/10/2023.
//

import UIKit

class CustomCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var cellImage: UIImageView!
    
    static let identifier = "CustomCollectionViewCell"
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public func configure(image : String){
        if let imageUrl = URL(string: image){
            URLSession.shared.dataTask(with: imageUrl) { (data, response, error) in
                if let error = error {
                    print("Erreur de téléchargement de l'image : \(error.localizedDescription)")
                    return
                }
                if let imageData = data {
                    DispatchQueue.main.async {
                        if let image = UIImage(data: imageData) {
                            self.cellImage.image = image
                        }
                    }
                }
            }.resume()
        }
    }

}
