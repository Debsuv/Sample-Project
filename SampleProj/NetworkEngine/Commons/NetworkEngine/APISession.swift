//
//  APISession.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 25/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation

protocol SessionProtocol {
    var session : URLSession { get }
}
struct APISession : SessionProtocol {
    private  init() {}
    
    static let sharedInstance : APISession = APISession()
    
    var session: URLSession = {
        
        let sessionConfig = URLSessionConfiguration.default
        sessionConfig.timeoutIntervalForRequest = TimeInterval(1000)
        sessionConfig.timeoutIntervalForResource = TimeInterval(1000)
        
        return URLSession(configuration: sessionConfig)
    }()

}

extension URLSession {
    func synchronousDataTask(urlrequest: URLRequest, callBack : @escaping(Data?,URLResponse?,Error?)->Void) -> URLSessionDataTask {
    
        let semaphore = DispatchSemaphore(value: 0)
        
        let dataTask = self.dataTask(with: urlrequest) {
            
            callBack($0,$1,$2)
            
            semaphore.signal()
        }
        dataTask.resume()
        
        defer{
             _ = semaphore.wait(timeout: .distantFuture)
        }

        return dataTask
        
       
    }
}
