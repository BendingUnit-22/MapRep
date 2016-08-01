//
//  MPService.swift
//  MaxRep
//
//  Created by Rixing Wu on 7/5/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import Foundation
import RealmSwift

class MPService: NSObject {
    static let sharedInstance = MPService()
    static let realm = try! Realm()
    var config = realm.objectForPrimaryKey(Configuration.self, key: "Configuration")
    
    private override init() {
        if config == nil{
            MPService.loadIinitalData()
        }
    }
    
   internal lazy var workouts : Results<Workout> = MPService.fetchAllWorkout()
    
}

//MARK: Static Application Service
extension MPService{
    
    // Fetch all workout objects
    private class func fetchAllWorkout() -> Results<Workout>{
       return realm.objects(Workout.self)
    }
    
    // Save realm object
    class func save(object: Object) throws{
        if object is Workout{
            try Workout.verify(object as! Workout)
        }
        try! realm.write {
            realm.add(object)
        }
    }
    
    //
    class func removeAll(){
        try! realm.write {
            realm.deleteAll()
        }
    }

    
    private class func loadIinitalData(){
        
        func createWorkout(name: String, type: HiiTType, r: Int, int: Double, low: Double, list: [String]){
            let routine = Routine(type: type, rounds: r, interval: int, low: low)
            let wk = Workout(name: name, routine: routine)
            for e : String in list{
                let exercise = Exercise(name: e)
                try! wk.append(exercise)
            }
            try! realm.write {
                realm.add(wk)
            }
        }
        
        let classic = ["Jumping Jacks", "High Knees", "Squat Jumps", "Plank Jacks","Mountain Climbers", "Plank Side Jumps", "Plank In and Out Jump", "Tuck Jumps", "Burpees"]
        
        let endurance = ["Jump Rope", "Treadmill"]
        
        let tababta = ["Standard Push-Ups", "Knee to Elbow Push Ups", "Push-Ups","Dips", "Arm Circles", "Diamond Push-Ups", "Lunges (Right)", "Lunges (Left)", "Calf Raise",  "Wall Squats"]
        
        createWorkout("High Intensity Interval Training", type: .Classic, r: 3, int: 45.0.seconds, low: 1.0.minute, list: classic)
        createWorkout("Strength Training", type: .Tabata, r: 6, int: 20.0.seconds, low: 10.0.seconds, list: tababta)
        createWorkout("Cardio Training", type: .Endurance, r: 15, int:1.0.minute, low: 1.0.minute, list: endurance)
        
        try! realm.write {
            realm.add(Configuration())
        }
        
    }
    

}



class Configuration:Object{
    dynamic var id = "Configuration"
    dynamic var appCreated = NSDate()
    override static func primaryKey() -> String?{
        return "id"
    }
}








