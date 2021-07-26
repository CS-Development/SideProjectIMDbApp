//
//  SideProjectIMDbAppTests.swift
//  SideProjectIMDbAppTests
//
//  Created by Christian Slanzi on 24.07.21.
//

import XCTest
import NetworkingService
import IMDbApiModule
@testable import SideProjectIMDbApp

class SideProjectIMDbAppTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        
        let apiKey = "FAKE_API_KEY"
        let client = URLSessionHTTPClient(session: URLSession.shared)
        let service = IMDbApiService(baseURL: URL(string: "https://imdb-api.com")!, client: client, apiKey: apiKey)
        //let manager = IMDbManager(service: service)
        let fakeManager = FakeIMDbManager(service: service)
        let viewController = ViewController(manager: fakeManager)
        viewController.viewDidLoad()
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
