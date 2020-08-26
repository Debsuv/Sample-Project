//
//  NetworkOperation.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 28/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation

class GroupOperation : AsyncOperation {
    
    let queue = OperationQueue()
    var operations: [Operation] = []
    
    override func execute() {
         queue.addOperations(operations, waitUntilFinished: true)
    }
    override func cancel() {
        super.cancel()
        for opt in operations {
            opt.cancel()
        }
    }
}
