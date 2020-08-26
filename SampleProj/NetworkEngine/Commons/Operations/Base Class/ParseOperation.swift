//
//  ParseOperation.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 28/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation
class ParseOperation<T> : AsyncOperation {
    var responseTuple : (Data?,Error?)?
    let callBack: ((T?,Error?) -> Void)
    
    init(parseCallBack : @escaping ((T?,Error?) -> Void)) {
        self.callBack = parseCallBack
    }
    
    override func cancel() {
        super.cancel()
        self.callBack(nil,nil)
       
    }
}


