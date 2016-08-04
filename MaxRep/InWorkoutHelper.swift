//
//  InWorkoutHelper.swift
//  MaxRep
//
//  Created by Rixing on 8/4/16.
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