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
    
}

//MARK: Boilerplat
extension Workout{
    
    
    
}


















