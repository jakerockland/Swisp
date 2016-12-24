//
//  EnvironmentTests.swift
//  SwispTests
//
//  MIT License
//
//  Copyright (c) 2016 Jake Rockland (http://jakerockland.com)
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this
//  software and associated documentation files (the "Software"), to deal in the Software
//  without restriction, including without limitation the rights to use, copy, modify,
//  merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit
//  persons to whom the Software is furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED,
//  INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
//  PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE
//  FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR
//  OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
//  DEALINGS IN THE SOFTWARE.
//

import XCTest
@testable import Swisp


/**
 Simple tests for the standard global environment
 */
class EnvironmentTests: XCTestCase {
    
    // MARK: - Set of All Tests
    
    /// All environment tests
    static var allTests : [(String, (EnvironmentTests) -> () throws -> Void)] {
        return [
            ("testMathConstants", testMathConstants),
            ("testAdd", testAdd),
            ("testSubtract", testSubtract),
            ("testMultiply", testMultiply),
            ("testDivide", testDivide),
            ("testMod", testMod),
            ("testGreaterThan", testGreaterThan),
            ("testLessThan", testLessThan),
            ("testGreaterThanEqual", testGreaterThanEqual),
            ("testLessThanEqual", testLessThanEqual),
            ("testEqual", testEqual),
            ("testAbs", testAbs),
            ("testCeil", testCeil),
            ("testCopySign", testCopySign),
            ("testFloor", testFloor),
            ("testFabs", testFabs),
        ]
    }
    

    // MARK: - Constant Values

    /// Value of mathematical constant π
    let π = 3.1415926535897932384626433832795

    /// Value of mathematical constant 𝑒
    let 𝑒 = 2.7182818284590452353602874713527


    // MARK: - Testing Properties

    var interpreter: Interpreter!


    // MARK: - Set Up Methods

    /**
     Called before every test method
     */
    override func setUp() {
        super.setUp()

        // Initialize our interpreter
        interpreter = Interpreter()
    }


    // MARK: - Constant Testing

    /**
    Tests our math constants for appropriate values
     */
    func testMathConstants() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(pi)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, π)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(π)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, π)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(e)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 𝑒)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(𝑒)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 𝑒)
        } catch {
            XCTFail()
        }
    }


    // MARK: - Operator Testing

    /**
     Tests our `+` function
     */
    func testAdd() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(+ 2 2)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 4)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(+ 2.0 2.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(+ 2.0 2)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(+ 2 2.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(+ two two)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? String, "twotwo")
        } catch {
            XCTFail()
        }
    }

    /**
     Tests our `-` function
     */
    func testSubtract() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(- 6 2)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 4)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(- 6.0 2.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(- 6.0 2)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(- 6 2.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }
    }

    /**
     Tests our `*` function
     */
    func testMultiply() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(* 2 2)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 4)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(* 2.0 2.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(* 2.0 2)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(* 2 2.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }
    }

    /**
     Tests our `/` function
     */
    func testDivide() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(/ 8 2)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 4)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(/ 8.0 2.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(/ 8.0 2)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(/ 8 2.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }
    }

    /**
     Tests our `%` function
     */
    func testMod() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(% 9 3)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(% 9 5)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 4)
        } catch {
            XCTFail()
        }
    }

    /**
     Tests our `>` function
     */
    func testGreaterThan() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(> 4 2)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(> 2.0 2.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(> hello world)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }
    }

    /**
     Tests our `<` function
     */
    func testLessThan() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(< 4 2)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(< 2.0 2.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(< hello world)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }
    }

    /**
     Tests our `>=` function
     */
    func testGreaterThanEqual() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(>= 4 2)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(>= 2.0 2.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(>= hello world)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }
    }

    /**
     Tests our `<=` function
     */
    func testLessThanEqual() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(<= 4 2)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(<= 2.0 2.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(<= hello world)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }
    }

    /**
     Tests our `=` function
     */
    func testEqual() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(= 4 2)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(= 2.0 2.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(= hello world)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }
    }


    // MARK: - Library Testing

    /**
     Tests our `abs` function
     */
    func testAbs() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(abs -10)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 10)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(abs -10.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 10.0)
        } catch {
            XCTFail()
        }
    }


    // MARK: - Math Testing

    /**
     Tests our `ceil` function
     */
    func testCeil() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(ceil -9.1)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, -9.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(ceil 9.1)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 10.0)
        } catch {
            XCTFail()
        }
    }

    /**
     Tests our `copysign` function
     */
    func testCopySign() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(copysign 5.0 -1.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, -5.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(copysign -5.0 1.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 5.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(copysign -5.0 -1.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, -5.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(copysign 5 -1)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, -5)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(copysign -5 1)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 5)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(copysign 5.0 -1)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, -5.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(copysign -5 1.0)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 5.0)
        } catch {
            XCTFail()
        }
    }

    /**
     Tests our `floor` function
     */
    func testFloor() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(floor -9.1)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, -10.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(floor 9.1)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 9.0)
        } catch {
            XCTFail()
        }
    }

    /**
     Tests our `fabs` function
     */
    func testFabs() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(fabs -9.1)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 9.1)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(fabs 9.1)")
            let result = try Interpreter.eval(&parsed, withEnvironment: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 9.1)
        } catch {
            XCTFail()
        }
    }

}
