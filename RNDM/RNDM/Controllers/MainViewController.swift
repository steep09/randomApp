//
//  ViewController.swift
//  RNDM
//
//  Created by Stephenson Ang on 10/24/19.
//  Copyright © 2019 Stephenson Ang. All rights reserved.
//

import UIKit

enum ThoughtCategory: String {
    case serious = "serious"
    case funny = "funny"
    case crazy = "crazy"
    case popular = "popular"
}

class MainViewController: UIViewController {
    
    @IBOutlet private weak var categorySegment: UISegmentedControl!
    
    @IBOutlet private weak var tableView: UITableView!
    
    var thoughtList = [Thought]()

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 150
        tableView.rowHeight = UITableView.automaticDimension
        
    }
    
    
}
extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return thoughtList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ThoughtListCell", for: indexPath) as? ThoughtListCell else { return UITableViewCell() }
        
        var thought = thoughtList[indexPath.row]
        
        cell.configureCell(thought: thought)
        
        return cell
    }
    
}
