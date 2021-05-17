//
//  MovieUITests.swift
//  MovieUITests
//
//  Created by Denys Nikolaichuk on 17.05.2021.
//

import XCTest

///
final class MovieAppMVVMUITests: XCTestCase {
    override func setUpWithError() throws {
        continueAfterFailure = false
    }

    override func tearDownWithError() throws {}

    func testUI() {
        let app = XCUIApplication()
        app.launch()
        app.tables.cells.staticTexts["Zack Snyder's Justice League"].tap()
        app.navigationBars.buttons["Movies"].tap()
        app.tables.staticTexts["Nobody"].tap()
        app.navigationBars.buttons["Movies"].tap()
        app.tables.staticTexts["Godzilla vs. Kong"].tap()
        app.navigationBars.buttons["Movies"].tap()
        app.tables.staticTexts["Vanquish"].tap()
        app.navigationBars.buttons["Movies"].tap()
        app.tables.staticTexts["The Unholy"].tap()
        app.navigationBars.buttons["Movies"].tap()
        app.tables.staticTexts["Thunder Force"].tap()
        app.navigationBars.buttons["Movies"].tap()
        app.tables.staticTexts["Sentinelle"].tap()
        app.navigationBars.buttons["Movies"].tap()
        app.accessibilityPerformMagicTap()
    }
}
