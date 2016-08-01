//
//  Queue.swift
//  MaxRep
//
//  Created by Rixing Wu on 7/29/16.
//  Copyright © 2016 Rixing Wu. All rights reserved.
//

import Foundation

class Queue<T>{
    // private array containing all elements
    private var elements = Array<T>()
    
    // total elements
    var count : Int {
        return elements.count
    }
    
    // append an item
    func enqueue(item: T){
        elements.append(item)
    }
    
    //remove an item
    func dequeue() -> T? {
        guard !elements.isEmpty else {
            return nil
        }
        return elements.removeAtIndex(0)
    }
    
    // peek at the next item
    func peek() -> T? {
        return elements.first
    }
    
}
