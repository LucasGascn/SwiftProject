//
//  LoginViewController.swift
//  sweetWatch
//
//  Created by Jules Duarte on 03/10/2023.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    var container: NSPersistentContainer!

    @IBOutlet weak var loginView: UIView!
    @IBOutlet weak var signUpView: UIView!
    
    @IBOutlet weak var passwordConnectionField: UITextField!
    @IBOutlet weak var emailConnectionField: UITextField!
    
    
    @IBOutlet weak var passwordSignUpField: UITextField!
    @IBOutlet weak var emailSignUpField: UITextField!
    
    var users : [NSManagedObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.signUpView.isHidden = true
        
        guard let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else {
              return
          }
          
        let managedContext =
            appDelegate.persistentContainer.viewContext
          
          //2
          let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "Users")
        
        do {
            users = try managedContext.fetch(fetchRequest)
          } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
          }

        print(users)
    }
    
    @IBAction func toggleLogin(_ sender: Any) {
        self.loginView.isHidden = false
        self.signUpView.isHidden = true
    }
    
    @IBAction func toggleSignUp(_ sender: Any) {
        self.loginView.isHidden = true
        self.signUpView.isHidden = false
    }

    
    @IBAction func Connection(_ sender: Any) {
    }
    
    @IBAction func SignUp(_ sender: Any) {
        var email = emailSignUpField.text ?? ""
        var password = passwordSignUpField.text ?? ""
        
        save(name: email, password: password)
        
        self.loginView.isHidden = true
        self.signUpView.isHidden = false
    }
    
    func save(name: String, password: String) {
      
      guard let appDelegate =
        UIApplication.shared.delegate as? AppDelegate else {
        return
      }
      
      // 1
      let managedContext =
        appDelegate.persistentContainer.viewContext
      
      // 2
      let entity =
        NSEntityDescription.entity(forEntityName: "Users",
                                   in: managedContext)!
      
      let User = NSManagedObject(entity: entity,
                                   insertInto: managedContext)
      
      // 3
      User.setValue(name, forKeyPath: "name")
      User.setValue(password, forKeyPath: "password")
        
      do {
        try managedContext.save()
          
      } catch let error as NSError {
        print("Could not save. \(error), \(error.userInfo)")
      }
    }

}
