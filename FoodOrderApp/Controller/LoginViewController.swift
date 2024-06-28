//
//  LoginViewController.swift
//  FoodOrderApp
//
//  Created by Aisha on 01.06.24.
//


import UIKit
class LoginViewController: UIViewController {
 
    @IBOutlet weak var emailTextField: UITextField!
    
 @IBOutlet weak var passwordTextField: UITextField!
    var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func loginTappedButton(_ sender: Any) {
    
        if emailTextField.text == user?.email &&
            passwordTextField.text == user?.password {
            guard let controller = storyboard?.instantiateViewController(withIdentifier: "TabNav") else {
                return
            }
//            let controller = storyboard?.instantiateViewController(identifier: "HomeViewController") as! HomeViewController
            UserDefaults.standard.set(true, forKey: "userRegistered")
            navigationController?.show(controller, sender: true)
        }
    }
    @IBAction func registerTappedButton(_ sender: Any) {
        
        let controller = storyboard?.instantiateViewController(identifier: "RegisterViewController") as! RegisterViewController
        
navigationController?.show(controller, sender: true)
        controller.callback = { user in
            self.user = user
            self.emailTextField.text = user.email
            self.passwordTextField.text = user.password
        }
    }

}


