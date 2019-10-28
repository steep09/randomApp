//
//  LoginViewController.swift
//  RNDM
//
//  Created by Stephenson Ang on 10/28/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailAdressTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var createUserBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loginBtn.layer.cornerRadius = 10.0
        createUserBtn.layer.cornerRadius = 10.0
    }
    
    @IBAction func loginBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func createUserBtnWasPressed(_ sender: Any) {
    }
    
}
