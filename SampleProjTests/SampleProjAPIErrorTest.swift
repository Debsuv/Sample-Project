//
//  SampleProjTests.swift
//  SampleProjTests
//
//  Created by Debanjan Chakraborty on 19/07/20.
//  Copyright © 2020 Debanjan Chakraborty. All rights reserved.
//

import XCTest
class SampleProjAPIErrorTest: XCTestCase {
    
    struct MockAPISession : SessionProtocol {
        private  init() {}
        
        static let sharedInstance : MockAPISession = MockAPISession()
        
        var session: URLSession = {
            
            let sessionConfig = URLSessionConfiguration.default
            sessionConfig.timeoutIntervalForRequest = TimeInterval(700)
            sessionConfig.timeoutIntervalForResource = TimeInterval(700)
            
            return URLSession(configuration: sessionConfig)
        }()
        
    }
    
    lazy var componentWith500Error: URLComponents = {
         var component = URLComponents()
           component.scheme = "http"
           component.host = "httpstat.us"
           component.path = "/500"
        return component
    }()
    
    struct SleepArgumentFor5000 : Argument {
        var keyName: String {
            return "sleep"
        }
        var value: CustomStringConvertible = 5000
    }
    
    


    var apiManager : SessionManager?
    
    
    override func setUp() {
        apiManager = SessionManager.init(httpSession: MockAPISession.sharedInstance.session)
    }

    override func tearDown() {
        apiManager = nil
    }
    
    func testForImproperResponse() {
        let respParser = CountryDetailsResponseParser()
        
        let validURLExpectation = expectation(description: "firing parse opt")
        respParser.decode(response: nil) { (response, error) in
            if let customError = error as? APIEngineError {
             XCTAssert(customError == APIEngineError.ImproperResponse, " no response received")
            }else{
                XCTAssert(false, "error is not an APEngineError")
            }
            
            validURLExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 700) { (error) in
                 XCTAssertNotNil(validURLExpectation)
               }
    }
    
    func testForImproperURL() {
        let val = "My Name Is Debanjan"
        
        let validURLExpectation = expectation(description: "This is an invalid data url")
        
        val.executeAPI(sessionManager: apiManager!) { (data, error) in
            
            if let customError = error as? APIEngineError {
               
                XCTAssert(customError == APIEngineError.ImproperURLError,"This is APIEngine.ImproperURLError")
            }
            validURLExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 700) { (error) in
          XCTAssertNotNil(validURLExpectation)
        }
    }
    
    func testURLForCountryDetails(){
        let url = URLComponents.countryDetailsComponent.url
        
        XCTAssertNotNil(url, "This url is not nil")
        
        let validURLExpectation = expectation(description: "This is a valid data url")
        
        url?.executeAPI(sessionManager: apiManager!) { (data, error) in
            XCTAssertNil(error,"There should be no error")
            
            XCTAssertNotNil(data, "data must not be nil")
            
            validURLExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 700) { (error) in
          XCTAssertNotNil(validURLExpectation)
        }
        
    }
    func testURL() {
        let val = "MyNameIsDebanjan.com"
        
        let validURLExpectation = expectation(description: "This is an invalid data url")
        
        val.executeAPI(sessionManager: apiManager!) { (data, error) in
            XCTAssertNotNil(error,"Invalid url error should be present")
            
            if let customError = error as? APIEngineError {
                XCTAssertNotNil(customError.description, "There should be a message")
               
                XCTAssert(customError == APIEngineError.ImproperURLError,"This is APIEngine.ImproperURLError")
            }
            validURLExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 700) { (error) in
          XCTAssertNotNil(validURLExpectation)
        }
    }
    
    func testURLFromComponent() {
        
        componentWith500Error.setQueryItems(params: [SleepArgumentFor5000()])
        let testURL = componentWith500Error.url
        
        let suggestedURLString = "http://httpstat.us/500?sleep=5000"
        
        XCTAssertNotNil(testURL, "URL should not be nil")
        
        let urlString = testURL!.absoluteString
        
        XCTAssertEqual(urlString,suggestedURLString , "The URL should match to \(suggestedURLString)")
        
    }
    
    
    func testAPICallWithMockSession(){

        componentWith500Error.setQueryItems(params: [SleepArgumentFor5000()])
        
        let urlExpectation = expectation(description: "There should be an error")
        
        let url = componentWith500Error.url
        
        XCTAssertNotNil(url, "URL should not be nil")
        
        url!.executeAPI(sessionManager: apiManager!) { (_, error) in
            if let customError = error as? APIEngineError {
                XCTAssertNotNil(customError.description, "There should be a message")
                urlExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 700) { (error) in
          XCTAssertNotNil(urlExpectation)
        }
    }
    
    
    func testAPICallWithOriginalSession(){

        componentWith500Error.setQueryItems(params: [SleepArgumentFor5000()])
        
        let urlExpectation = expectation(description: "There should be an error")
        
        let url = componentWith500Error.url
        
        XCTAssertNotNil(url, "URL should not be nil")
    
        let newURL = url!
        
        newURL.executeAPI { (_, error) in
            if let customError = error as? APIEngineError {
                XCTAssertNotNil(customError.description, "There should be a message")
                urlExpectation.fulfill()
            }
        }
        
        waitForExpectations(timeout: 700) { (error) in
          XCTAssertNotNil(urlExpectation)
        }
    }
    
}
