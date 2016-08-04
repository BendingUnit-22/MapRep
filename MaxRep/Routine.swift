//
//  Routine.swift
//  MaxRep
//
//  Created by Rixing Wu on 7/11/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import RealmSwift
import Foundation

enum HiiTType: Int{
    case Classic
    case Tabata
    case Endurance
}

class Routine: Object {
    
    dynamic var typeID = HiiTType.Classic.rawValue
    dynamic var rounds = 1
    dynamic var interval:Double = 0.0
    dynamic var intervalLow:Double = 0.0
    
    //
    var type : HiiTType{
        get{ return HiiTType(rawValue: typeID)!
        }
        set{ typeID = newValue.rawValue
        }
    }
    
    convenience init(type: HiiTType, rounds: Int, interval: Double, low: Double){
        self.init()
        self.type = type
        self.rounds = rounds
        self.interval = interval
        self.intervalLow = low
    }
    
  
    
}

