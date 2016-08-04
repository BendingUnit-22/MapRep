//
//  ViewController.swift
//  MaxRep
//
//  Created by Rixing Wu on 6/22/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

protocol HomeViewControllerDelegate {
    func didAddWorkout()
}


class HomeViewController: UIViewController {
    //Properties
    var workouts : Results<Workout>!
    
    @IBOutlet weak var tableView: UITableView!
    @IBAction func addWorkout(sender: AnyObject) {
        self.performSegueWithIdentifier("addWorkout", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        didAddWorkout()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
}


// MARK: TableViewController
extension HomeViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
       let cell =  tableView.dequeueReusableCellWithIdentifier("workoutcell") as! WorkoutSelectionCell
        let wkt = workouts[indexPath.row]
        let route = wkt.routine!
        let type = "\(route.type)"
        cell.imgView.image =  UIImage(named: type)
        cell.title.text = wkt.name
        cell.type.text = type
        cell.routine.text = "\(wkt.exercises.count) x \(route.rounds)"
        cell.duration.text = wkt.workoutDuration().timeFormat
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let workout = workouts[indexPath.row]
        self.performSegueWithIdentifier("toPreWorkout", sender: workout)
    }
    

    
}

// MARK: Segue Routing
extension HomeViewController{
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "addWorkout"{
            let vc = segue.destinationViewController as! AddViewController
            vc.delegate = self
        }
        
        if segue.identifier == "toPreWorkout"{
            let vc = segue.destinationViewController as! PreWorkoutViewController
            vc.workout = sender as! Workout
        }
    }
    
    
    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue){}
    
}


// MARK: HomeViewControllerDelegate
extension HomeViewController: HomeViewControllerDelegate{
    func didAddWorkout() {
        workouts = MPService.sharedInstance.workouts
        self.tableView.reloadData()
    }
}














