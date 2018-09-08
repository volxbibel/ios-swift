//
//  VolxbibelUITests.swift
//  VolxbibelUITests
//
//  Created by Simon Brüchner on 19.11.17.
//  Copyright © 2017 Brüchner IT Consulting. All rights reserved.
//

import XCTest

class VolxbibelUITests: XCTestCase {
        
    override func setUp() {
        super.setUp()
        
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false
        // UI tests must launch the application that they test. Doing this in setup will make sure it happens for each test method.
        // XCUIApplication().launch()

        
        let app = XCUIApplication()
        setupSnapshot(app)
        app.launch()
        
        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        snapshot("Buchuebersicht")
        let app = XCUIApplication()
        let tablesQuery = app.tables
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Johannes"]/*[[".cells.staticTexts[\"Johannes\"]",".staticTexts[\"Johannes\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("Kapitelübersicht")
        tablesQuery/*@START_MENU_TOKEN@*/.staticTexts["Kapitel 3"]/*[[".cells.staticTexts[\"Kapitel 3\"]",".staticTexts[\"Kapitel 3\"]"],[[[-1,1],[-1,0]]],[0]]@END_MENU_TOKEN@*/.tap()
        snapshot("Verse mit Ueberschrift")
        let textView = app.otherElements.containing(.navigationBar, identifier:"Kapitel 3").children(matching: .other).element.children(matching: .other).element.children(matching: .other).element.children(matching: .textView).element
        textView.swipeUp()
        textView.swipeUp()
        snapshot("Johannes 3,16")
        
    }
    
}
