//
//  ImageCacheUnitTest.swift
//  SampleProjTests
//
//  Created by Debanjan Chakraborty on 26/08/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import XCTest

class ImageCacheUnitTest: XCTestCase {
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testWithProperImage() throws {
        
        let imageURL = "https://blog.kromatic.com/wp-content/uploads/2015/11/illustration-market-research-v1.png"
        
        let validImageExpectation = expectation(description: "This is a valid data url")
        let imageView = UIImageView()
        
        imageView.loadImage(for: imageURL) { (image, error) in
            
            XCTAssert(image != nil , "There should be a valid image data ")
            XCTAssert(error == nil , "No error should be found")
            
            validImageExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 700) { (error) in
          XCTAssertNotNil(validImageExpectation)
        }
    }
    
    func testWithImproperImage() throws {
        
        let imageURL = "https://www.google.com/url?sa=i&url=https%3A%2F%2Fkromatic.com%2Fblog%2Fhow-to-verify-your-assumptions-at-small-sample-sizes%2F&psig=AOvVaw2tN2MNRiY5R28KRR-rQGQS&ust=1598549544032000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCPC71Z-zuesCFQAAAAAdAAAAABAD"
        
        let validImageExpectation = expectation(description: "This is a valid data url")
        let imageView = UIImageView()
        
        imageView.loadImage(for: imageURL) { (image, error) in
            
            XCTAssert(image == nil , "NO image data is to be recovered")
            
            validImageExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 700) { (error) in
          XCTAssertNotNil(validImageExpectation)
        }
    }
    
    
    func testWithProperImageURL() throws {
        
        let imageURL = URL.init(string: "https://blog.kromatic.com/wp-content/uploads/2015/11/illustration-market-research-v1.png")
        
        let validImageExpectation = expectation(description: "This is a valid data url")
        let imageView = UIImageView()
        
        imageView.loadImage(for: imageURL!) { (image, error) in
            
            XCTAssert(image != nil , "There should be a valid image data ")
            XCTAssert(error == nil , "No error should be found")
            
            validImageExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 700) { (error) in
          XCTAssertNotNil(validImageExpectation)
        }
    }
    
    func testWithImproperImageURL() throws {
        
        let imageURL = URL.init(string:"https://www.google.com/url?sa=i&url=https%3A%2F%2Fkromatic.com%2Fblog%2Fhow-to-verify-your-assumptions-at-small-sample-sizes%2F&psig=AOvVaw2tN2MNRiY5R28KRR-rQGQS&ust=1598549544032000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCPC71Z-zuesCFQAAAAAdAAAAABAD")
        
        let validImageExpectation = expectation(description: "This is a valid data url")
        let imageView = UIImageView()
        
        imageView.loadImage(for: imageURL!) { (image, error) in
            
            XCTAssert(image == nil , "NO image data is to be recovered")
            
            validImageExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 700) { (error) in
          XCTAssertNotNil(validImageExpectation)
        }
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
