//
//  ViewController.swift
//  sweetWatch
//
//  Created by lucas Gascoin on 03/10/2023.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var background: UIImageView!
    @IBOutlet weak var button: UIButton!
    
//    var container: NSPersistentContainer!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let timer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: true) { timer in
            self.ChangeBackground()
        }
//        guard container != nil else {
//                    fatalError("This view needs a persistent container.")
//                }
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if let nextVC = segue.destination as? LoginViewController {
//                nextVC.container = container
//            }
//        }
//    
    func ChangeBackground() {
        let imgNumber = Int.random(in: 1..<10)
        
        UIView.transition(with: self.background,
                          duration: 1.5,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    self.background.image = UIImage(imageLiteralResourceName: "img\(imgNumber)")
                }, completion: nil)
    }

    @IBAction func displayLogin(_ sender: Any) {
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "login") as? LoginViewController {
        
            
            self.present(vc, animated: true, completion: nil)

        }
    }
    
}

