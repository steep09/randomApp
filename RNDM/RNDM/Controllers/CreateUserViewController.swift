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
    
    @IBOutlet weak var errorMessageLbl: UILabel!
    @IBOutlet weak var errorMessageView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createBtn.layer.cornerRadius = 10.0
        cancelBtn.layer.cornerRadius = 10.0
        errorMessageView.layer.cornerRadius = 10.0
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
                            debugPrint("ERROR CREATING USER: \(String(describing: error))")
                        } else {
                            
                            let changeRequest = result?.user.createProfileChangeRequest()
                            changeRequest?.displayName = username
                            changeRequest?.commitChanges(completion: { (error) in
                                if let error = error {
                                    debugPrint(error.localizedDescription)
                                }
                            })
                            
                            guard let userId = result?.user.uid else { return }
                            Firestore.firestore().collection(users_ref)
                                .document(userId).setData([
                                    USERNAME: username,
                                    "emailAddress": email,
                                    DATECREATED: FieldValue.serverTimestamp()
                                ]) { (error) in
                                    if let error = error {
                                        debugPrint("ERROR CREATING FIRESTORE DATA: \(error.localizedDescription)")
                                        self.errorMessageView.showToastMessage(label: self.errorMessageLbl, message: "\(error.localizedDescription)")
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
