//
//  SphAssignmentUITests.swift
//  SphAssignmentUITests
//
//  Created by Nobin Thomas on 22/1/19.
//  Copyright © 2019 Nobin Thomas. All rights reserved.
//

import XCTest

class SphAssignmentUITests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        XCUIApplication().launch()

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery.staticTexts["2011"].tap()
        
        let dismissButton = app.alerts["Info"].buttons["Dismiss"]
        dismissButton.tap()
        tablesQuery/*@START_MENU_TOKEN@*/.cells.containing(.staticText, identifier:"2004")/*[[".cells.containing(.staticText, identifier:\"0.0009269999999999999\")",".cells.containing(.staticText, identifier:\"2004\")"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.buttons["More Info"].tap()
        app.alerts["Alert"].buttons["Dismiss"].tap()
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["2011"]/*[[".cells.staticTexts[\"2011\"]",".staticTexts[\"2011\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.swipeUp()
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

}
