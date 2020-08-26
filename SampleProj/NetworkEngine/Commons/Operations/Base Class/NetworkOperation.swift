//
//  NetworkOperation.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 28/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation
class NetworkOperation<T> : GroupOperation {
    
    init(request : ServiceProtocol,
         sessionManager : SessionManagerProtocol? = nil,
         parseOperation : ParseOperation<T>,
         requestType : String = "GET")
    {
        super.init()
        
        let apiCall = APICallOperation.init(request: request, sessionManager: sessionManager, requestType: requestType)
        
        let adapter = BlockOperation() { [unowned apiCall, unowned parseOperation] in
            if (self.isCancelled){
            }else{
                parseOperation.responseTuple = apiCall.responseTuple
            }
            
        }
        
        adapter.addDependency(apiCall)
        parseOperation.addDependency(adapter)
        
        operations = [apiCall,parseOperation,adapter]
    }
}
