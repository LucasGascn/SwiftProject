//
//  ActorsCollectionViewCell.swift
//  sweetWatch
//
//  Created by coding on 05/10/2023.
//

import UIKit

class ActorsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var actorsViewCell: UIImageView!
    
    @IBOutlet weak var actorsNameLabel: UILabel!
    static let identifier = "ActorsCollectionViewCell"
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
                            self.actorsViewCell.image = image
                        }
                    }
                }
            }.resume()
        }
    }

}
