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
    let networkServiceLeagues: FetchLeagues = NetworkSevice()
    let networkServiceLeaguesDetails: FetchLeaguesDetails = NetworkSevice()

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
    
    func testFetchLeagues(){
        let expectaion = expectation(description: "Waiting for the API")
        networkServiceLeagues.getLeagues(strSport: "Soccer") { (items, error) in
            guard let items = items else{
                XCTFail()
                expectaion.fulfill()
                return
            }
            XCTAssertEqual(items.countries?.count, 10, "API Faild")
            expectaion.fulfill()
        }
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFetchLeaguesTeams(){
         let expectaion = expectation(description: "Waiting for the API")
        networkServiceLeaguesDetails.getLeaguesTeams(strLeague:"English Premier League") { (items, error) in
             guard let items = items else{
                 XCTFail()
                 expectaion.fulfill()
                 return
             }
            XCTAssertEqual(items.teams?.count, 20, "API Faild")
             expectaion.fulfill()
         }
         waitForExpectations(timeout: 10, handler: nil)
     }
    
    func testFetchLatestEvents(){
        let expectaion = expectation(description: "Waiting for the API")
        networkServiceLeaguesDetails.getAllEvents(leagueId: "4328") {(items, error) in
             guard let items = items else{
                 XCTFail()
                 expectaion.fulfill()
                 return
             }
            XCTAssertEqual(items.events?.count, 100, "API Faild")
             expectaion.fulfill()
         }
         waitForExpectations(timeout: 10, handler: nil)
    }
}
