//
//  AddViewController.swift
//  MaxRep
//
//  Created by Rixing Wu on 6/27/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import UIKit
import RealmSwift


protocol AddViewControllerDelegate {
    func  didAppendExercise(e: Exercise)
}



class AddViewController: UITableViewController {
    
    var delegate: HomeViewControllerDelegate?
    
    @IBOutlet weak var count: UILabel!
    @IBOutlet weak var exerciseInterval: UITextField!
    @IBOutlet weak var repeats: UITextField!
    @IBOutlet weak var workoutName: UITextField!
    var workout =  Workout()
    
    override func viewDidLoad() {}
    
    
    @IBAction func save(sender: AnyObject) {
        workout.name = workoutName.text!
//        workout.rounds = Int(repeats.text!)!
//        workout.interval = Double(exerciseInterval.text!)!
        do {
           try MPService.save(workout)
        }catch {
            print("Error Occur!")
        }
        delegate?.reloadWorkoutList()
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.destinationViewController is AppendViewController{
            let app = segue.destinationViewController as! AppendViewController
            app.delegate = self
        }
    }
    
}



extension AddViewController: AddViewControllerDelegate{
    func didAppendExercise(e:Exercise) {
        try! workout.append(e)
        count.text = "Count: \(workout.exercises.count)"
    }
}


