//
//  HomeView.swift
//  MaxRep
//
//  Created by Rixing Wu on 7/9/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//


import UIKit

class HomeView: HomeViewController {

    var timer: TaskTimer!
    var running = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
       
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
         self.tableView.reloadData()
    
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = super.tableView(tableView, cellForRowAtIndexPath: indexPath) as! WorkoutSelectionCell
        return cell
    }
    
    

  
}
