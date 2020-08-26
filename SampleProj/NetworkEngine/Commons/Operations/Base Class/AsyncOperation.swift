//
//  AsyncOperation.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 28/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation

class AsyncOperation: Operation {
    override var isAsynchronous: Bool {
        return true
    }
    
    var _isFinished: Bool = false
    
    override var isFinished: Bool {
        set {
            willChangeValue(forKey: "isFinished")
            _isFinished = newValue
            didChangeValue(forKey: "isFinished")
        }
        
        get {
            return _isFinished
        }
    }

    var _isExecuting: Bool = false
    
    override var isExecuting: Bool {
        set {
            willChangeValue(forKey: "isExecuting")
            _isExecuting = newValue
            didChangeValue(forKey: "isExecuting")
        }
        
        get {
            return _isExecuting
        }
    }
    
    var _isCancelled: Bool = false
       
       override var isCancelled: Bool {
           set {
               willChangeValue(forKey: "isCancelled")
               _isCancelled = newValue
               didChangeValue(forKey: "isCancelled")
           }
           
           get {
               return _isCancelled
           }
       }
    
    @objc func execute() {
    }
    
    override func start() {
        isExecuting = true
        isCancelled = false
        execute()
        isExecuting = false
        isFinished = true
    }
    override func cancel() {
        isCancelled = true
        isExecuting = false
        isFinished = true
    }
}
