//
//  NetworkServiceTests.swift
//  SportsTests
//
//  Created by abdelrahmanhz on 5/12/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import XCTest
@testable import Sports

class NetworkServiceTests: XCTestCase {
    
    let networkService: FetchSports = NetworkSevice()

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchSports(){
        let expectaion = expectation(description: "Waiting for the API")
        networkService.getSports() { (items, error) in
            guard let items = items else{
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertEqual(items.sports?.count, 34, "API Faild")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }

}
