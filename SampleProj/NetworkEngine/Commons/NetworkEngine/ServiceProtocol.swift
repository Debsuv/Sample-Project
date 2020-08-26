//
//  SessionManager.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 23/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation

protocol ServiceProtocol {
    @discardableResult  func executeAPI(sessionManager : SessionManagerProtocol?,
                                       isSynchronous : Bool,
                                       with headers : [Argument]?,
                                       requestType : String?,
                                       for completion : @escaping (Data?,Error?) -> Void) -> URLSessionDataTask?
}

extension String : ServiceProtocol {
    
    @discardableResult func executeAPI(sessionManager : SessionManagerProtocol? = nil,
                                        isSynchronous : Bool = false,
                                        with headers : [Argument]? = nil,
                                        requestType : String? = nil,
                                       for completion: @escaping (Data?, Error?) -> Void)-> URLSessionDataTask? {
        
        guard let url = URL(string: self) else {
            completion(nil,APIEngineError.ImproperURLError)
            return nil
        }
        
        let task = url.executeAPI(sessionManager: sessionManager,
                                  isSynchronous: isSynchronous,
                                  with: headers,
                                  requestType: requestType,
                                  for: completion)

        return task
    }
}

extension URL : ServiceProtocol{
    
    @discardableResult func executeAPI(sessionManager : SessionManagerProtocol? = nil,
                                       isSynchronous : Bool = false,
                                       with headers : [Argument]? = nil,
                                       requestType : String? = nil,
                                       for completion: @escaping (Data?, Error?) -> Void)-> URLSessionDataTask? {
        
        let task = URLRequest(url: self).executeAPI(sessionManager: sessionManager,
                                                    isSynchronous: isSynchronous,
                                                    with: headers,
                                                    requestType: requestType,
                                                    for: completion)
        
        return task
    }
}

extension URLRequest : ServiceProtocol{
    
    @discardableResult func executeAPI(sessionManager : SessionManagerProtocol? = nil,
                                       isSynchronous : Bool = false,
                                       with headers : [Argument]? = nil,
                                       requestType : String? = nil,
                                       for completion: @escaping (Data?, Error?) -> Void)-> URLSessionDataTask? {
        
        var networkSessionManager = sessionManager
        if (sessionManager == nil){
            networkSessionManager = SessionManager.init(httpSession: APISession.sharedInstance.session) 
        }
        
        let req =  self.prepareTheRequest(with: headers)
        let task = networkSessionManager!.executeSession(request: req,isSynchronous: isSynchronous) { (data, error) in
            completion(data,error)
        }
        
        return task
    }
    
    func prepareTheRequest(with headers : [Argument]?, requestType : String = "GET") -> URLRequest{
        
        var copy = self
        
        if let headerArg = headers {
            for arg in headerArg {
                copy.addValue(arg.getValue, forHTTPHeaderField: arg.keyName)
            }
        }
        
        copy.httpMethod = requestType
     
        return copy
    }
}
