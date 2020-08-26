//
//  CountryDetailsOperation.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 29/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation

class CountryDetailsOperation : NetworkOperation<CountryDetailsRespone>{
    
    let url : URL
    init(callBack : @escaping (CountryDetailsRespone?,Error?) -> Void){
        
        let comp = URLComponents.countryDetailsComponent
        
        self.url = comp.url!
        
        let parseOperation = CountryDetailsParseOperation(parseCallBack: callBack)
        
        super.init(request: url, parseOperation: parseOperation)
    }
}
