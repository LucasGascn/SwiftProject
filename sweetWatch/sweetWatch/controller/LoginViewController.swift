//
//  LoginViewController.swift
//  sweetWatch
//
//  Created by Jules Duarte on 03/10/2023.
//

import UIKit
import CoreData

class MainTabBarController : UITabBarController{
    
}
class LoginViewController: UIViewController {

    var container: NSPersistentContainer!

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signUpView: UIView!
    
    @IBOutlet weak var passwordConnectionField: UITextField!
    @IBOutlet weak var emailConnectionField: UITextField!
    
    
    @IBOutlet weak var passwordSignUpField: UITextField!
    @IBOutlet weak var emailSignUpField: UITextField!
    
    @IBOutlet weak var toggleOutlet: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.signUpView.isHidden = true
    
    }
    
    @IBAction func Connection(_ sender: Any) {
        var email = emailConnectionField.text ?? ""
        var password = passwordConnectionField.text ?? ""
        let dataManager = CoreDataManager()
        let params = ["name" : email, "password" : password]
        let user = dataManager.fetchObjects(Users.self, withArguments: params).first
        
        guard user != nil else {
            print("no user found")
            return
        }
        print("username : \(user?.name), password : \(user?.password), movies : \(user?.movies), series : \(user?.series)")
        if let movies = user?.movies {
            let movieArray = movies.allObjects as? [Movies]
            
            for movie in movieArray ?? []{
                print(movie.name)
                print(movie.synopsis)
            }
        }
        
        if let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "tabBarController") as? MainTabBarController {
            UserDefaults.standard.set(user?.name, forKey: "username")
            UserDefaults.standard.set(user?.password, forKey: "password")
            
            vc.modalPresentationStyle = .fullScreen
            self.present(vc, animated: true, completion: nil)

        }
    }
    
    @IBAction func SignUp(_ sender: Any) {
        var email = emailSignUpField.text ?? ""
        var password = passwordSignUpField.text ?? ""
        var movies : [Movies.Type] = []
        var series : [Series.Type] = []
        let dataManager = CoreDataManager()
        let params :[String:Any] = ["name" : email, "password" : password, "movies" : movies, "series" : series]
        dataManager.save(entityName: "Users", params: params)
        
        self.loginView.isHidden = false
        self.signUpView.isHidden = true
        self.toggleOutlet.selectedSegmentIndex = 0
    }
    
    
    @IBAction func toggleView(_ sender: Any) {
        switch self.toggleOutlet.selectedSegmentIndex{
        case 0:
            self.loginView.isHidden = false
            self.signUpView.isHidden = true
        case 1 :
            self.loginView.isHidden = true
            self.signUpView.isHidden = false
        default:
            break
        }
    }
    
    
    
}
