//
//  InWorkoutViewController.swift
//  MaxRep
//
//  Created by Rixing Wu on 6/30/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import UIKit



class InWorkoutViewController: UIViewController {
    
    
    @IBOutlet weak var workoutView: WorkoutView!
    
    @IBAction func stop(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    var workout: Workout!
    var timer : TaskTimer!
    var on_completion: (() -> Void)?
    var stats = [String:Status?]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        workout.delegate = self
        timer = workout.createTaskTimer()
        timer.start()
        if timer.currTask != nil{
            initLabel(timer.currTask!.label)
            updateWorkoutView(Double(timer.currTask!.duration), roundL: 0)
        }
        
    }

    func updateWorkoutView(timeL: Double, roundL: Int){
        self.workoutView.timeLabel.text = timeL.timeFormat
        self.workoutView.roundLabel.text = "\(roundL) of \(workout.routine!.rounds)"
        if timeL == 3.0{
            SpeechSynthesizer().playSound()
        }
    }

}


//MARK: InWorkoutDelegate
extension InWorkoutViewController: WorkoutDelegate{
    
    func updateRestProgress(label: String, progress: Double) {
        updateWorkoutView(progress, roundL: 0)
    }
    
    func updateExerciseProgress(ex: Exercise, status: Status){
        updateWorkoutView(status.progress, roundL: status.cRound)
        stats[ex.name] = status
    }
    
    func initLabel(text: String) {
        self.navigationController?.navigationBar.topItem?.title = text
        if self.timer.nextTask != nil{
            self.workoutView.nextLabel.text = self.timer.nextTask!.label
        }
    }
    
    func didFinish() {
        self.dismissViewControllerAnimated(true, completion: nil)
        on_completion?()
    }
    
}