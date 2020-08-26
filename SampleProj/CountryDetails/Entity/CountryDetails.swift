//
//  CountryDetails.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 22/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation

struct CountryDetails : Codable {
    let title : String?
    let description : String?
    let imageHref : String?
    enum CodingKeys: String, CodingKey {
        case imageHref
        case title
        case description
    }
}
