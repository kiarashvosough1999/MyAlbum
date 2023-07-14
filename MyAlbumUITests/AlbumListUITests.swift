//
//  AlbumListUITests.swift
//  MyAlbumUITests
//
//  Created by Kiarash Vosough on 7/13/23.
//

import XCTest

final class AlbumListUITests: XCTestCase {

    private var app: XCUIApplication!

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
        _ = app.waitForExistence(timeout: 5)
    }

    override func tearDownWithError() throws {
        app = nil
    }

    func testNavigationBars() throws {
        XCTAssertEqual(app.navigationBars.element.identifier, "Albums")
    }
    
    func testButtons() throws {
        XCTAssert(app.buttons.count > 4)
    }
    
    func testScrollView() throws {
        let element = app.scrollViews.element
        XCTAssertEqual(element.exists, true)
    }
    
    func testImages() throws {
        let element = app.images.element
        XCTAssert(app.images.count > 4)
        XCTAssert(element.waitForExistence(timeout: 5))
        XCTAssert(element.exists)
    }
    
    func testTexts() throws {
        let element = app.staticTexts
        
        let query = element.matching(NSPredicate(format: "label == %@", "Albums"))
        
        XCTAssert(query.element.exists)
        XCTAssert(element.count > 4)
    }
}
