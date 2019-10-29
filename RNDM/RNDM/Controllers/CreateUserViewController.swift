//
//  CreateUserViewController.swift
//  RNDM
//
//  Created by Stephenson Ang on 10/28/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit
import Firebase

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
        
        if emailAddressTxtField.text != "" && passwordTxtField.text != "" {
            if (emailAddressTxtField.text?.contains("@"))! {
                if passwordTxtField.text!.count >= 6 {
                    guard let email = emailAddressTxtField.text,
                        let password = passwordTxtField.text,
                        let username = userNameTxtField.text
                    else { return }
                    Auth.auth().createUser(withEmail: email, password: password) { (result, error) in
                        if error != nil {
                            print("ERROR CREATING USER: \(error ?? nil)")
                        } else {
                            print("USER: \(result)")
                            
                            guard let userId = result?.user.uid else { return }
                            Firestore.firestore().collection("Users")
                                .document(userId).setData([
                                    "userName": username,
                                    "dateCreated": FieldValue.serverTimestamp()
                                ]) { (error) in
                                    if error != nil {
                                        debugPrint("ERROR CREATING FIRESTORE DATA: \(error)")
                                    } else {
                                        self.emailAddressTxtField.text = ""
                                        self.passwordTxtField.text = ""
                                        self.userNameTxtField.text = ""
                                        self.dismiss(animated: true, completion: nil)
                                    }
                            }
                        }
                    }
                }
            }
        }
    }
    
    @IBAction func cancelBtnWasPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
