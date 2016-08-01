//
//  PreWorkoutViewController.swift
//  Created by Rixing Wu on 6/29/16.
//

import UIKit

class PreWorkoutViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var workout: Workout!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.alwaysBounceVertical = false
        let ges = UISwipeGestureRecognizer(target: self, action: #selector(PreWorkoutViewController.swipeDown))
        ges.direction = .Down
        self.tableView.addGestureRecognizer(ges)
    
    }
    
    func swipeDown() {
        self.performSegueWithIdentifier("segueUnwind", sender: self)
    }
}


// MARK: Table View

extension PreWorkoutViewController: UITableViewDataSource, UITableViewDelegate{
    
    @IBAction func startWorkout(sender: AnyObject) {
        self.performSegueWithIdentifier("toInWorkout", sender: self)
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! PreWorkoutCell
        let cIndex = indexPath.row
        let count = workout.exercises.count
        cell.title.text = workout.exercises[cIndex].name
        if count > 1 {
            if cIndex == 0{
                cell.connector = .Down
            }else if cIndex == count-1{
                cell.connector = .Up
            }else{
                cell.connector = .Both
            }
        }
        return cell
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let wkt = workout
        let cell =  tableView.dequeueReusableCellWithIdentifier("header") as! HeaderCell
        let type = "\(wkt.routine!.type)"
        cell.title.text = wkt.name
        cell.type.text = type
        return tableView.dequeueReusableCellWithIdentifier("header")! as UIView
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workout.exercises.count
    }
    
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 150
    }
    
}

// MARK: Segues


extension PreWorkoutViewController{
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "toInWorkout"{
            let wkVC = segue.destinationViewController.childViewControllers[0] as! InWorkoutViewController
            wkVC.workout = self.workout
        }
    }
    
    
}












