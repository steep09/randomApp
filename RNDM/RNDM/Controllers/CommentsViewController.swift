//
//  CommentsViewController.swift
//  RNDM
//
//  Created by Stephenson Ang on 10/29/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController {
    
    @IBOutlet var keyboardView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addCommentTxtField: UITextField!
    
    var thought: Thought!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addCommentBtnWasPressed(_ sender: Any) {
    }
    
}
