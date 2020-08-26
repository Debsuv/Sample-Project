//
//  CountryDetailsParseOperation.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 29/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation
class CountryDetailsParseOperation : ParseOperation<CountryDetailsRespone>{
    
    lazy var countryParser: CountryDetailsResponseParser = {
        let cParser = CountryDetailsResponseParser()
        return cParser
    }()
    override func execute() {
        guard self.isCancelled == false else {
            self.callBack(nil,nil)
            return
        }
        guard let response = self.responseTuple else {
            return
        }
        
        self.parseCountryLogic(response: response)
    }
    
    
    func parseCountryLogic(response : (Data?,Error?)){
        countryParser.decode(response: response.0) { [weak self](countryDetails, error) in
            if let cancellStat = self?.isCancelled, cancellStat == true{
                self?.callBack(nil,nil)
            }else{
                self?.callBack(countryDetails,error)
            }
        }
    }
}

