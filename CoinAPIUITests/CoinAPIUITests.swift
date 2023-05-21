import XCTest

final class CoinAPIUITests: XCTestCase {

    let app = XCUIApplication()
    
    func test_isHomeScreenPresented() {
        app.launch()
        XCUIApplication().navigationBars["HOME"].staticTexts["HOME"].tap()
        XCTAssert(app.staticTexts["HOME"].exists)
    }
}

