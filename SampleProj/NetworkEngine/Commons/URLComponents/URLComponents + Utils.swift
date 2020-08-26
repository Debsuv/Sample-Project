//
//  URLComponents + Utils.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 22/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation


extension URLComponents {
    
    mutating func setQueryItems(params : [Argument]){
        
        var perentEncodedItems = [URLQueryItem]()
        
        let cs = CharacterSet.urlQueryAllowed
        
        for item in params {
            
            let value = item.getValue.addingPercentEncoding(withAllowedCharacters: cs)
            let queryItem = URLQueryItem(name: item.keyName, value: value)
            perentEncodedItems.append(queryItem)
        }
        
        
        self.populateQueryItems(encodedQueryItems: perentEncodedItems)
    }
    
    mutating private func populateQueryItems(encodedQueryItems : [URLQueryItem]){
        
        if #available(iOS 11.0, *) {
            if self.percentEncodedQueryItems == nil {
                self.percentEncodedQueryItems = encodedQueryItems
            }else {
                self.percentEncodedQueryItems?.append(contentsOf: encodedQueryItems)
            }
        } else {
            if self.queryItems == nil {
                self.queryItems = encodedQueryItems
            }else {
                self.queryItems?.append(contentsOf: encodedQueryItems)
            }
        }
    }
}
