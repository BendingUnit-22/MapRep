//
//  InWorkoutHelper.swift
//  MaxRep
//
//  Created by Rixing on 8/4/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import UIKit


enum WorkoutState{
    case Ready, InProgress, Resting, Paused, Resumed, Completed
}

protocol WorkoutDelegate{
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

