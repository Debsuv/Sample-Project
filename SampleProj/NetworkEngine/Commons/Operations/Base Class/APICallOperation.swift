//
//  APICallOperation.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 28/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation
class APICallOperation : AsyncOperation {
    
    let request : ServiceProtocol
    let sessionManager : SessionManagerProtocol?
    
    var responseTuple : (Data?,Error?)
    
    private var dataTask : URLSessionDataTask?
    
    private var headerInfo : [Argument]?
    
    private var requestType : String?
    
    init(request : ServiceProtocol, sessionManager : SessionManagerProtocol? = nil ,  with headers : [Argument]? = nil,
         requestType : String?){
        self.request = request
        self.sessionManager = sessionManager
        
        self.headerInfo = headers
        self.requestType = requestType
    }
    
    override func execute() {
        
        self.dataTask = request.executeAPI(sessionManager: sessionManager, isSynchronous: true, with: self.headerInfo, requestType: self.requestType, for: { (data, error) in
            self.dataTask = nil
            if self.isCancelled == false {
                self.responseTuple = (data, error)
            }else{
                self.responseTuple = (nil, nil)
            }})
        
    }
    
    override func cancel() {
        super.cancel()
        if let task = self.dataTask {
            task.cancel()
        }
    }
    
}
