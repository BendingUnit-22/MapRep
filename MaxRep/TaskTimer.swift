//
// TaskTimer
//
// Copyright (c) 2015-2016 Rixing Wu
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in all
// copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
// SOFTWARE.
//


import Foundation

typealias ProgressClosure =  (progress: Int) -> Void



class Task{
    var label: String
    var duration: Int
    var pClosure : ProgressClosure!
    
    init(label: String, duration: Int, pClosure : ProgressClosure){
        self.label = label
        self.duration = duration
        self.pClosure = pClosure
    }
    
    func timePass(){
        self.duration-=1
    }
    
    func  shouldContinue() -> Bool {
        return self.duration > 0
    }
}


class TaskTimer{
    
    private var queue : Queue<Task>!
    private var timer = NSTimer()
    private var currTask : Task?
    private var nextTask : Task?
    
    init(){
        self.queue = Queue<Task>()
    }

    
    func add(task: Task){
        queue.enqueue(task)
    }
    
    func start()  {
        print("Task Timer started")
        nextIteration()
    }
    
    func pause(){
       print("Paused")
       self.timer.invalidate()
    }
    
    func resume() {
        guard self.currTask != nil else {return}
        runTask(self.currTask!)
    }
    
    private func nextIteration() {
        if let task = queue.dequeue(){
              currTask = task
              nextTask = queue.peek()
              runTask(task)
        }else{
            finish()
        }
    }
    
    private func runTask(task: Task){
        timer = NSTimer.new(every: 1.0, {
            task.timePass()
            task.pClosure(progress: task.duration)
            if !task.shouldContinue(){
                self.timer.invalidate()
                print(task.label + " completed")
            }
        })
        timer.start()
    }
    
    func finish() {
        print("All Task Completed")
    }
}






