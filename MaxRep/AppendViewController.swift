//
//  AppendViewController.swift
//  MaxRep
//
//  Created by Rixing Wu on 6/27/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import UIKit

class AppendViewController: UITableViewController {
    
    @IBOutlet weak var exerciseName: UITextField!
    var delegate: AddViewControllerDelegate?
    
    @IBAction func addExercise(sender: AnyObject) {
        if !exerciseName.text!.isEmpty{
            let exercise = Exercise(name: exerciseName.text!)
            delegate?.didAppendExercise(exercise)
            self.navigationController?.popViewControllerAnimated(true)
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    


}
