//
//  InWorkoutViewController.swift
//  MaxRep
//
//  Created by Rixing Wu on 6/30/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import UIKit


protocol InWorkoutDelegate{
    func updateExerciseProgress(ex: Exercise,  status: Status)
    func updateRestProgress(label: String, progress: Double)
    func initLabel(text: String)
    func didFinish()
}

struct Status {
    var progress: Double
    var cRound: Int
    func percent(base: Int) -> CGFloat  {
        return CGFloat(cRound)/CGFloat(base)
    }
}


class InWorkoutViewController: UIViewController {
    
    var workout: Workout!
    var timer : TaskTimer?
    var on_completion: (() -> Void)?
    var stats = [String:Status?]()
    @IBAction func stop(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        workout.delegate = self
        timer = workout.createTaskTimer()
        timer?.start()
    }
    
}


//MARK: Timer
extension InWorkoutViewController: InWorkoutDelegate{
    
    func updateRestProgress(label: String, progress: Double) {
        
    }
    
    func updateExerciseProgress(ex: Exercise, status: Status){
        stats[ex.name] = status
    }
    
    func initLabel(text: String) {
        self.navigationController?.navigationBar.topItem?.title = text
    }
    
    func didFinish() {
        stop(self)
        on_completion?()
    }
    
}