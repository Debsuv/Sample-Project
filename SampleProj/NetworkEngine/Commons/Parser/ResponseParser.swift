//
//  ResponseParser.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 28/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation

protocol ResponseParser{
    associatedtype T
}

extension ResponseParser where T: Decodable{
    
    var defaultJsonDecoder : JSONDecoder {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }
    
    func decode(response: Data?, completion : @escaping(T?,Error?)->Void) {
        
        guard let resp = response else {
            completion (nil,APIEngineError.ImproperResponse)
            return
        }
        
         let stringDataValue = String(decoding: resp, as: UTF8.self)
        
        if let correctedData = stringDataValue.data(using: .utf8) {
            do {
                let decodedObject = try defaultJsonDecoder.decode(T.self, from: correctedData)
                completion(decodedObject,nil)
            } catch let e {
                completion(nil,e)
            }
        }else{
            completion(nil,APIEngineError.ImproperResponse)
        }
    }
}



class CountryDetailsResponseParser : ResponseParser {
    typealias T  = CountryDetailsRespone
}


