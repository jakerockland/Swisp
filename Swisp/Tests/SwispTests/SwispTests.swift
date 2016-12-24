import XCTest
@testable import Swisp

class SwispTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Swisp().text, "Hello, World!")
    }


    static var allTests : [(String, (SwispTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
