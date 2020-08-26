//
//  CountryViewModel.swift
//  SampleProj
//
//  Created by Debanjan Chakraborty on 26/08/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import Foundation

class CountryViewModel {
    
    private var dataSource : [CountryDetails]? = nil
    private var loadOperation : CountryDetailsOperation? = nil
    
    var onCompletion: ((_ success: Bool, _ error : Error?) -> Void)
    
    init(with completionCallBack : @escaping ((_ success: Bool, _ error : Error?) -> Void)) {
        self.onCompletion = completionCallBack
    }
    
    func load(){
        
        self.loadOperation = CountryDetailsOperation.init { [weak self] (response, error) in
            
            if let resp = response, let strongSelf = self {
                
                if let details = resp.rows {
                    
                    strongSelf.dataSource = details.filter({ (detail) -> Bool in
                        return detail.title != nil && detail.description != nil
                    })
                }
                           
                strongSelf.onCompletion(true,error)
            }else{
                self?.dataSource = nil
                
                self?.onCompletion(false,error)
            }
           
        }
        
        self.loadOperation!.start()
    }
    
    var elementCount : Int {
        if let dataArray = self.dataSource {
            return dataArray.count
        }
        return 0
    }
    
    func getData(for pos : Int) -> CountryDetails? {
        
        if let dataArray = self.dataSource, pos < dataArray.count {
            return dataArray[pos]
        }
        
        return nil
    }
}
