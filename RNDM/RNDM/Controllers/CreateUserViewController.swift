//
//  CreateUserViewController.swift
//  RNDM
//
//  Created by Stephenson Ang on 10/28/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit

class CreateUserViewController: UIViewController {

    @IBOutlet weak var emailAddressTxtField: UITextField!
    @IBOutlet weak var passwordTxtField: UITextField!
    @IBOutlet weak var userNameTxtField: UITextField!
    @IBOutlet weak var createBtn: UIButton!
    @IBOutlet weak var cancelBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createBtn.layer.cornerRadius = 10.0
        cancelBtn.layer.cornerRadius = 10.0
    }
    
    @IBAction func createBtnWasPressed(_ sender: Any) {
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
    }
    
}
