//
//  InWorkoutViewController.swift
//  MaxRep
//
//  Created by Rixing Wu on 6/30/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import UIKit

class InWorkoutViewController: UIViewController {
    
    var workout: Workout!

    
    @IBAction func stop(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(workout.name)
        
    }
    
  
}


//MARK: Timer
extension InWorkoutViewController{
    
    
    
    
    
}