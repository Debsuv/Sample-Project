//
//  Argument.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 22/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation

protocol Argument {
    var keyName : String {get}
    var value : CustomStringConvertible {get set}
}
extension Argument {
    var getValue : String{
        return value.description
    }
}



