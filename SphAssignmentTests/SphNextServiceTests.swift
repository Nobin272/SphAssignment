//
//  SphNextServiceText.swift
//  SphAssignmentTests
//
//  Created by BeConnect on 23/1/19.
//  Copyright © 2019 Nobin Thomas. All rights reserved.
//

import XCTest

class SphNextServiceTests: XCTestCase, MobileDataUsageStoreDelegate {
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testNextLoading() {
        MobileDataUsageStore.shared.nextUrl = "/api/action/datastore_search?offset=40&limit=40&resource_id=a807b7ab-6cad-4aa6-87d0-e283a7353a0f"
        MobileDataUsageStore.shared.delegate = self
        MobileDataUsageStore.shared.nextMobileDataUsageStore()
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    //Mark:- utils
    func didDataRefresh(items: [MobileDataRecord]) {
        XCTAssert(items.count > 0, "The server should resspond with valid JSON");
    }
    
    func didDataChanged(newlyAdded: [MobileDataRecord]) {
        XCTAssert(newlyAdded.count > 0, "The server should resspond with valid JSON");
    }
    
    func didDataFailed(message: String) {
        XCTAssertFalse(message.count > 0, "The server failed to respond");
    }
    
}
