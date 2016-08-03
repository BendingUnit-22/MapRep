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
    var exercises = List<Exercise>()
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
    
    // classic d = ((count * interval) + low) * rounds
    //endurance = count * (rounds * (interval + low))
    // tabata = count * (rounds * (interval + low))
    
    func workoutDuration() -> Double {
        let route = self.routine!
        let count = Double(exercises.count)
        let interval = route.interval
        let low = route.intervalLow
        let rounds = Double(route.rounds)
        switch route.type {
        case .Classic:
            return (count * interval + low) * rounds
        case .Endurance:
            return count * (rounds * (interval + low))
        case .Tabata:
            return count * (rounds * (interval + low))
        }
    }
    
}

//MARK: Boilerplat
extension Workout{
    
    
    
}


















