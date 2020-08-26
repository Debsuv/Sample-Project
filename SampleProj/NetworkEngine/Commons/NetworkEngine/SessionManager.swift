//
//  SessionManager.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 23/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation

protocol SessionManagerProtocol {
    @discardableResult mutating func executeSession(request : URLRequest,
                                                    isSynchronous : Bool,
                                                    completion : @escaping(Data?,Error?)->Void) -> URLSessionDataTask
}


struct SessionManager : SessionManagerProtocol {
    
    var httpSession: URLSession
    
    @discardableResult mutating func executeSession(request : URLRequest,
                                                    isSynchronous : Bool = false,
                                                    completion : @escaping (Data?,Error?)->Void) -> URLSessionDataTask{
        
        let genericCompletionHandler : (Data?, URLResponse?, Error?) -> Void = {data,response,error  in
            
            if let apiError = APIEngineError.checkResponseForError(with: response){
                completion(nil, apiError)
            }
            
            completion(data,error)
        }
        
        var task : URLSessionDataTask
        if (isSynchronous){
            task = httpSession.synchronousDataTask(urlrequest: request,callBack: genericCompletionHandler)
        }else {
            task = httpSession.dataTask(with: request, completionHandler: genericCompletionHandler)
        }
        
        task.resume()
        return task
    }
}
