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
    private var commentList = [Comment]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
    }

    @IBAction func addCommentBtnWasPressed(_ sender: Any) {
        
    }
    
}
extension CommentsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        commentList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CommentsCell", for: indexPath) as? CommentsCell
            else { return UITableViewCell() }
        
        cell.configureCell(comment: commentList[indexPath.row])
        return cell
    }
    
}
