//
//  APIEngineError.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 24/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation

enum APIEngineError : LocalizedError{
    case NetworkError(status : Int,message : String)
    
    static func checkResponseForError(with response : URLResponse?) -> APIEngineError? {
        if let resp = response as? HTTPURLResponse {
            let statusCode = resp.statusCode
            
            if ((200...299).contains(statusCode) == false ){
                
                let msg = HTTPURLResponse.localizedString(forStatusCode: statusCode)
                
                let apiError = APIEngineError.getError(statusCode: statusCode, message: msg)
                
                return apiError
            }
        }
        return nil
    }
    
    static func getError(statusCode:Int,message: String) -> APIEngineError{
        return APIEngineError.NetworkError(status:statusCode,message: message)
    }
    private var statusCode : Int {
        switch self {
         case .NetworkError(let e):
                   return e.status
        }
    }
}


extension APIEngineError : Equatable {
    static func == (lhs: APIEngineError, rhs: APIEngineError) -> Bool {
        return lhs.statusCode == rhs.statusCode
    }
}

extension APIEngineError {
    
    public var description : String {
        switch self {
        case .NetworkError(let e):
            return e.message
        }
    }
}
