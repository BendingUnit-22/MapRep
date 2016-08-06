//
//  PreWorkout+Extension.swift
//  MaxRep
//
//  Created by Rixing Wu on 8/5/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import Foundation
import UIKit

extension PreWorkoutViewController{
    
    func addSwipeDownGesture() {
        let ges = UISwipeGestureRecognizer(target: self, action: #selector(PreWorkoutViewController.on_swipeDown))
        ges.direction = .Down
        self.view.addGestureRecognizer(ges)
    }
    
    func on_swipeDown() {
        if navController != nil{
            confirmQuit()
        }else{
            self.performSegueWithIdentifier("segueUnwind", sender: self)
        }
    }
    
    
    /**
    *      Untested
    */
    func confirmQuit(){
        let alertController = UIAlertController(title: "Attempt to quit", message: "All your progess will be lost!", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Destructive) { (alert) in
            self.inWorkoutController?.timer?.stop()
            self.performSegueWithIdentifier("segueUnwind", sender: self)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: nil)
        alertController.addAction(okAction)
        alertController.addAction(cancelAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    func on_WorkoutComplete(){
        controlBtn?.setTitle("Finish", forState: .Normal)
        let alertController = UIAlertController(title: "Finished", message: "", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: .Destructive) { (alert) in
        }
        alertController.addAction(okAction)
        self.presentViewController(alertController, animated: true, completion: nil)
    }
}










