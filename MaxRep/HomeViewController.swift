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
    func reloadWorkoutList()
}


class HomeViewController: UIViewController {
    //MARK: IBOulets
    @IBOutlet weak var tableView: UITableView!
    @IBAction func returnFromSegueActions(sender: UIStoryboardSegue){}
    @IBAction func addWorkout(sender: AnyObject) {
        self.performSegueWithIdentifier("addWorkout", sender: self)
    }
    //Properties
    var workouts : Results<Workout>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        reloadWorkoutList()
        tableView.delegate = self
        tableView.dataSource = self
        self.automaticallyAdjustsScrollViewInsets = false
        self.tableView.contentInset = UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
         self.tableView.reloadData()
    }
}


/** MARK: TableViewController
 */
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


/** MARK: Segue Routing
 */
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

}


/** MARK: HomeViewControllerDelegate
 */
extension HomeViewController: HomeViewControllerDelegate{
    func reloadWorkoutList() {
        workouts = MPService.sharedInstance.workouts
        self.tableView.reloadData()
    }
}














