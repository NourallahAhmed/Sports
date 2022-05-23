//
//  MockNetworkManagerTest.swift
//  SportsTests
//
//  Created by Abdelrahman on 5/23/22.
//  Copyright © 2022 NourAllah Ahmed. All rights reserved.
//

import XCTest
@testable import Sports

class MockNetworkManagerTest: XCTestCase {

    let myMock = MockNetworkManager(shouldReturnError: false)
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testFetchSports(){
        myMock.getSports() { (allSports, error) in
            guard let sports = (allSports as? AllSports)?.sports else{
                XCTFail()
                return
            }
            XCTAssertEqual(sports.count, 34, "failed")
        }
    }

}
