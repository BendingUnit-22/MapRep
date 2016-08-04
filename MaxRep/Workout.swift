//
//  Workout.swift
//  MaxRep
//
//  Created by Rixing Wu on 6/27/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import Foundation
import RealmSwift



class Workout : Object{
    dynamic var name = ""
    dynamic var createdAt = NSDate()
    dynamic var routine : Routine?
    
    var restBetweenSets = 2.0.minutes
    
    var exercises = List<Exercise>()
    
    var delegate : InWorkoutDelegate?
    
    func append(execise: Exercise) throws{
        guard !execise.name.isEmpty else{
            throw MPError.EmptyEntry
        }
        
        exercises.append(execise)
    }
    
    //
    convenience init(name: String, routine: Routine){
        self.init()
        self.name = name
        self.routine = routine
    }
    
    override static func primaryKey() -> String?{
        return "name"
    }
    
    //
    class func verify(workout: Workout) throws{
        guard !workout.name.isEmpty else {
            throw MPError.EmptyEntry
        }
        guard try! Realm().objects(Workout.self).filter(NSPredicate(format: "name=%@", workout.name)).count <= 0 else{
            throw MPError.DuplicateEntry
        }
        guard !workout.exercises.isEmpty else{
            throw MPError.EmptyArray
        }
        
    }
    
    
    func workoutDuration() -> Double {
        let route = self.routine!
        let count = Double(exercises.count)
        let interval = route.interval
        let low = route.intervalLow
        let rounds = Double(route.rounds)
        

        switch route.type {
        case .Classic:
            return (count * interval + low) * rounds
        default:
            return count * (((rounds-1) * (interval + low)) + (interval + restBetweenSets))
        }

    }
    func createTaskTimer() -> TaskTimer{
        let taskTimer = TaskTimer()
        let rounds = routine!.rounds
        let interval = routine!.interval
        let restOrLow = routine!.intervalLow
        let excercises = self.exercises
        
        
        func classicTimer(){
            for i in 0..<rounds{
                for e in excercises{
                    let task = createTask(e, duration: Int(interval), round: i+1)
                    taskTimer.add(task)
                }
                let rest = createRest("Water Break", duration:Int(restOrLow))
                taskTimer.add(rest)
            }
        }
        
        
        func linearTimer(){
            for e in excercises{
                for i in 0..<rounds{
                    let task = createTask(e, duration: Int(interval),round: i+1)
                    taskTimer.add(task)
                    if i != rounds-1{
                        let low = createRest("Rest Pace", duration:Int(restOrLow))
                        taskTimer.add(low)
                    }
                }
                let rest = createRest("Water Break", duration: Int(restBetweenSets))
                taskTimer.add(rest)
            }
        }
        
        
        switch self.routine!.type{
        case .Classic:
            classicTimer();break
        default:
            linearTimer()
        }
        
        
        taskTimer.on_finish = {
            self.delegate?.didFinish()
        }

        return taskTimer
    }
    

    
}

//MARK: Boilerplat
extension Workout{
    
    private func createTask(ex: Exercise, duration: Int, round: Int) -> Task{
        let task = Task(label: ex.name, duration: duration) { (progress) in
            let status = Status(progress: Double(progress), cRound: round)
            self.delegate?.updateExerciseProgress(ex, status: status)
        }
        
        task.intialClosure = {
            self.delegate?.initLabel(ex.name)
        }
        
        
        return task
    }
    
    private func createRest(label: String, duration: Int) -> Task{
        let task = Task(label: label, duration: duration) { (progress) in
            self.delegate?.updateRestProgress(label, progress: Double(progress))
        }
        task.intialClosure = {
            self.delegate?.initLabel(label)
        }
        return task
    }
}


















