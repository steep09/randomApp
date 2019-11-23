//
//  LoginViewController.swift
//  RNDM
//
//  Created by Stephenson Ang on 10/28/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailAdressTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createUserBtn: UIButton!
    
    @IBOutlet weak var errorMessageLbl: UILabel!
    @IBOutlet weak var errorMessageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.layer.cornerRadius = 10.0
        createUserBtn.layer.cornerRadius = 10.0
        errorMessageView.layer.cornerRadius = 10.0
    }
    
    @IBAction func loginBtnWasPressed(_ sender: Any) {
        
        guard let email = emailAdressTxtField.text,
            let password = passwordTxtField.text else { return }
        
        Auth.auth().signIn(withEmail: email, password: password) { (result, error) in
            if let error = error {
                debugPrint("ERROR SIGNING IN: \(error)")
                self.errorMessageView.showToastMessage(label: self.errorMessageLbl, message: "\(error.localizedDescription)")
            } else {
                self.dismiss(animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func createUserBtnWasPressed(_ sender: Any) {
        let createUserVC = storyboard?.instantiateViewController(withIdentifier: "CreateUserViewController") as! CreateUserViewController
        
        createUserVC.modalPresentationStyle = .fullScreen
        self.present(createUserVC, animated: true, completion: nil)
    }
    
}
