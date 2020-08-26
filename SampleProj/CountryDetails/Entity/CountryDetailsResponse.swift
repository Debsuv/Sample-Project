//
//  CountryDetailsRespone.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 22/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation

struct CountryDetailsRespone : Codable{
    
    let title : String?
    let rows : [CountryDetails]?

    enum CodingKeys: String, CodingKey {

        case title = "title"
        case rows = "rows"
    }
}
