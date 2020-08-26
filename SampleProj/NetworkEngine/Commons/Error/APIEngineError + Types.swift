//
//  APIEngineError + Types.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 28/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation

extension APIEngineError {
    static var ImproperURLError:  APIEngineError {
        return  APIEngineError.getError(statusCode: 999, message: "Improper url provided")
    }
    
    static var ImproperResponse:  APIEngineError {
        return  APIEngineError.getError(statusCode: 998, message: "No response to parse")
    }
}
