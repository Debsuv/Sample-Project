//
//  URLComponents + URL_Constants.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 22/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation

extension URLComponents {
    
    static var baseURLComponent : URLComponents {
        var comp = URLComponents();
        comp.scheme = "https"
        comp.host = "dl.dropboxusercontent.com"
        return comp;
    }
    
    static var countryDetailsComponent : URLComponents {
        var comp = URLComponents.baseURLComponent
        comp.path = "/s/2iodh4vg0eortkl/facts.json"
        return comp
    }
    
}
