//
//  SampleProjViewModelTest.swift
//  SampleProjTests
//
//  Created by Debanjan Chakraborty on 26/08/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import XCTest

class SampleProjViewModelTest: XCTestCase {

    var countryDetailsVM : CountryViewModel? = nil
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSample() {
        countryDetailsVM = CountryViewModel.init(with: { (success, error) in
            
            XCTAssert(success == true, "some response is being received")
        })
        
        countryDetailsVM?.load()
    }
    

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
