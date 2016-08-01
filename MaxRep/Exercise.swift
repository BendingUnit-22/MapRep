//
//  Exercise.swift
//  MaxRep
//
//  Created by Rixing Wu on 6/22/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import Foundation
import RealmSwift

class Record: Object{
    dynamic var createAt = NSDate()
    dynamic var reps: Int = 0
    
    convenience init(reps: Int){
        self.init()
        self.reps = reps
    }
}

class Exercise : Object{
    dynamic var name : String = ""
    let records = List<Record>()
    convenience init(name: String) {
        self.init()
        self.name = name
    }
    
    func createRecord(reps: Int){
        MPService.realm.beginWrite()
        let record = Record(reps: reps)
        self.records.append(record)
        try! MPService.realm.commitWrite()
    }
    
    override var description : String {
        return "Exercise: Records: \(records.count)"
    }
    
}






