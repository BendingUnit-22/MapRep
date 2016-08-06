//
//  PreWorkoutViewController.swift
//  Created by Rixing Wu on 6/29/16.
//

import UIKit
import ChameleonFramework

class PreWorkoutViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var workout: Workout!
    var navController : UINavigationController?
    var inWorkoutController: InWorkoutViewController?
    var headerView: HeaderCell?
    var globalTime : Double = 0.0
    var controlBtn : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.alwaysBounceVertical = false
        addSwipeDownGesture()
    }

    override func viewWillAppear(animated: Bool) {
        if let btn = controlBtn{
            btn.setTitle("Resume", forState: .Normal)
            btn.backgroundColor = UIColor.flatRedColor()
            self.tableView.reloadData()
        }
        inWorkoutController?.timer?.pause()
    }
}


// MARK: Table View

extension PreWorkoutViewController: UITableViewDataSource, UITableViewDelegate{
    
    @IBAction func startWorkout(sender: AnyObject) {
        if navController == nil{
            self.performSegueWithIdentifier("toInWorkout", sender: self)
            startTimerEvent(sender)
        }else{
            inWorkoutController?.timer?.resume()
            self.presentViewController(navController!, animated: true, completion: nil)
        }

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! PreWorkoutCell
        let cIndex = indexPath.row
        let count = workout.exercises.count
        let exercise = workout.exercises[cIndex]
        cell.title.text = exercise.name
        if let s = inWorkoutController?.stats[exercise.name]{
            let percent = s!.percent(workout.routine!.rounds)
            cell.fillPercent(percent)
        }

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
        if headerView == nil{
            let wkt = workout
            let cell =  tableView.dequeueReusableCellWithIdentifier("header") as! HeaderCell
            let type = "\(wkt.routine!.type)"
            cell.title.text = wkt.name
            cell.type.text = type
            cell.duration.text = wkt.workoutDuration().timeFormat
             self.headerView = cell
        }
        return self.headerView
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
            let nav = segue.destinationViewController as! UINavigationController
            navController = nav
            let wkVC = navController!.childViewControllers[0] as! InWorkoutViewController
            inWorkoutController = wkVC
            wkVC.workout = self.workout
            wkVC.on_completion = {
                self.on_WorkoutComplete()
            }
        }
    }
    
    private func startTimerEvent(sender: AnyObject?){
        controlBtn = sender as? UIButton
        headerView?.durationLabel.text = "elapsed"
        let timer = NSTimer.new(every: 1.0) {
            self.headerView?.duration.text = self.globalTime.timeFormat
            self.globalTime += 1.0
        }
        timer.start()
    }
    

}
















