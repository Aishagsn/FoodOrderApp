//
//  RegisterViewController.swift
//  FoodOrderApp
//
//  Created by Aisha on 01.06.24.
//
import UIKit

class RegisterViewController: UIViewController {

    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var phoneNumberTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    
    @IBOutlet weak var fullnameTextField: UITextField!
    
        let userDefaults = UserDefaults.standard
    
    var callback: ((User) -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Register"
        
    }
    
    @IBAction func registerActionButton(_ sender: Any) {
        if let name = fullnameTextField.text ,
           let email = emailTextField.text,
           let number = phoneNumberTextField.text,
           let password = passwordTextField.text {
            let model = User(fullname: name,
                             email: email,
                             phoneNumber: number,
                             password: password)
            userDefaults.set(name, forKey: "fullname")
            userDefaults.set(email, forKey: "email")
            userDefaults.set(number, forKey: "phoneNumber")
            callback?(model)
            navigationController?.popViewController(animated: true)
        }
    }

}
