//
//  Error.swift
//  MaxRep
//
//  Created by Rixing Wu on 7/1/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import Foundation


enum MPError: ErrorType, CustomStringConvertible{
    case DuplicateEntry
    case EmptyEntry
    case EmptyArray
    case NotExist
    var description: String{
        switch self {
        case .DuplicateEntry:
            return "Error. Duplicate Entry!"
        case .EmptyEntry:
            return "Field(s) cannot be empty"
        case .EmptyArray:
            return "No Entries has added!"
        case .NotExist:
            return "Oops, object cannot be save at this time"
        }
    }
}