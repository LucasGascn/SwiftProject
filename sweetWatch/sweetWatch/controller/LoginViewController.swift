//
//  LoginViewController.swift
//  sweetWatch
//
//  Created by Jules Duarte on 03/10/2023.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signUpView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.signUpView.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func toggleLogin(_ sender: Any) {
        self.loginView.isHidden = false
        self.signUpView.isHidden = true
    }
    
    @IBAction func toggleSignUp(_ sender: Any) {
        self.loginView.isHidden = true
        self.signUpView.isHidden = false
    }

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
