//
//  EnvironmentTests.swift
//  SwispTests
//
//  MIT License
//
//  Copyright (c) 2018 Jake Rockland (http://jakerockland.com)
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

@testable import SwispFramework
import XCTest

/**
 Simple tests for the standard global environment
 */
public class EnvironmentTests: XCTestCase {

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
    override public func setUp() {
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
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, π)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(π)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, π)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(e)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 𝑒)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(𝑒)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
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
            parsed = try Interpreter.parse("(+ \(Int.max) 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, Double(Int.max))
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(+ 2 2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 4)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(+ 2.0 2.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(+ 2.0 2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(+ 2 2.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(+ two two)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? String, "twotwo")
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(+ two 2)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(+ 2)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `-` function
     */
    func testSubtract() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(- \(-Int.max) 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, Double(-Int.max))
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(- 6 2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 4)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(- 6)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, -6)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(- 6.0 2.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(- 6.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, -6.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(- 6.0 2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(- 6 2.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(- two two)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(- two)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `*` function
     */
    func testMultiply() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(* \(Int.max) 2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, (Double(Int.max) * 2))
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(* 2 2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 4)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(* 2.0 2.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(* 2.0 2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(* 2 2.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(* two two)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(* 2)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `/` function
     */
    func testDivide() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(/ \(Int.max) 0.5)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, (Double(Int.max) / 0.5))
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(/ 8 2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 4)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(/ 8.0 2.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(/ 8.0 2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(/ 8 2.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(/ two two)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(/ 2)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `%` function
     */
    func testMod() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(% 9 3)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(% 9 5)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 4)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(% two 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(% 2)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `>` function
     */
    func testGreaterThan() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(> 4 2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(> 2.0 2.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(> hello world)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(> hello world)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(> two 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(> 2)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `<` function
     */
    func testLessThan() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(< 4 2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(< 2.0 2.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(< hello world)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(< two 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(< 2)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `>=` function
     */
    func testGreaterThanEqual() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(>= 4 2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(>= 2.0 2.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(>= hello world)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(>= two 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(>= 2)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `<=` function
     */
    func testLessThanEqual() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(<= 4 2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(<= 2.0 2.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(<= hello world)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(<= two 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(<= 2)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `=` function
     */
    func testEqual() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(= 4 2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(= 2.0 2.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(= hello world)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(= two 2)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(= 2)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
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
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 10)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(abs -10.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 10.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(abs negativeone)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(abs 2 3)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `append` function
     */
    func testAppend() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(append (quote (1 2)) (quote ()))")
            var result = try Interpreter.eval(parsed, with: &interpreter.globalEnv) as Any
            XCTAssertEqual(Interpreter.schemeString(&result), "(1 2)")
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(append (quote ()) (quote (3 4)))")
            var result = try Interpreter.eval(parsed, with: &interpreter.globalEnv) as Any
            XCTAssertEqual(Interpreter.schemeString(&result), "(3 4)")
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(append (quote (1 2)) (quote (3 4)))")
            var result = try Interpreter.eval(parsed, with: &interpreter.globalEnv) as Any
            XCTAssertEqual(Interpreter.schemeString(&result), "(1 2 3 4)")
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(append 2 3)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(append (quote (1 2)))")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `car` function
    */
    func testCar() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(car (quote (1 2)))")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 1)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(car (quote (1)))")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 1)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(car 3)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(car (quote (1 2)) (quote (1 2)))")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `cdr` function
     */
    func testCdr() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(cdr (quote (1 2 3)))")
            var result = try Interpreter.eval(parsed, with: &interpreter.globalEnv) as Any
            XCTAssertEqual(Interpreter.schemeString(&result), "(2 3)")
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(cdr (cdr (quote (1 2 3))))")
            var result = try Interpreter.eval(parsed, with: &interpreter.globalEnv) as Any
            XCTAssertEqual(Interpreter.schemeString(&result), "(3)")
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(cdr 3)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(cdr (quote (1 2)) (quote (1 2)))")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }
    
    /**
     Tests our `length` function
     */
    func testLength() {
        var parsed: Any
        
        do {
            parsed = try Interpreter.parse("(length (quote (1 2 3 4 5)))")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 5)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(length (quote (1 2 3)))")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 3)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(length (quote ()))")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 0)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(length 3)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(length (1 2 3 ))")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }
    
    /**
     Tests our `list` function
     */
    func testList() {
        var parsed: Any
        
        do {
            parsed = try Interpreter.parse("(list 1 2 3 4 5)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? [Int], [1,2,3,4,5])
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(list 1010101)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? [Int], [1010101])
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(list (list 1 3) (list 2 4))")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? [[Int]], [[1,3], [2,4]])
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(list 1.0 2.0 3.0 4.0 5.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? [Double], [1,2,3,4,5])
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(list (list 1.0 3.0) (list 2.0 4.0))")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? [[Double]], [[1,3], [2,4]])
        } catch {
            XCTFail()
        }
    }
    
    /**
     Tests our `list?` function
     */
    func testIsList() {
        var parsed: Any
        
        do {
            parsed = try Interpreter.parse("(list? (quote (1 2 3 4 5)))")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(list? 1010101)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(list? (quote ()))")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(list? foo bar)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(list? (1 2 3))")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }
    
    /**
     Tests our `max` function
     */
    func testMax() {
        var parsed: Any
        
        do {
            parsed = try Interpreter.parse("(max -100.0 -298.0 -390 -3909 -309498 -1.0 -39)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, -1)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(max 1.0 2.0 3.0 4.0 5.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 5.0)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(max 100.0 298 390.0 3909 309498 1.0 39)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 309498)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(max 100 -298 -390 -3909 -309498 1 39)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 100)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(max -100 -298 -390 -3909 -309498 -1 -39)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, -1)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(max (> 2 1))")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(max true false)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(max $$$)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }
    
    /**
     Tests our `min` function
     */
    func testMin() {
        var parsed: Any
        
        do {
            parsed = try Interpreter.parse("(min -100.0 -298.0 -390 -3909 -309498 -1.0 -39)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, -309498)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(min 1.0 2.0 3.0 4.0 5.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 1.0)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(min 100.0 298 390.0 3909 309498 1.0 39)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 1.0)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(min 100 -298 -390 -3909 -309498 1 39)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, -309498)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(min 100 298 390 3909 309498 1 39)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 1)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(min (> 2 1))")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(min true false)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(min $$$)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }
    
    /**
     Tests our `not` function
     */
    func testNot() {
        var parsed: Any
        
        do {
            parsed = try Interpreter.parse("(not true)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(not false)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(not 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(not 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(not (> 2 1))")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(not true false)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(not $$$)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }
    
    /**
     Tests our `number?` function
     */
    func testIsNumber() {
        var parsed: Any
        
        do {
            parsed = try Interpreter.parse("(number? true)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(number? 12.4)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(number? pi)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(number? 3)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(number? (list 1 2 3))")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(number? 1 2)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(number? 1.0 1)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }
    
    /**
     Tests our `round` function
     */
    func testRound() {
        var parsed: Any
        
        do {
            parsed = try Interpreter.parse("(round 3)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 3)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(round 2.5)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 3)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(round 2.1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 2)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(round -0.5)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, -1)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(round true)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(round -0.5 0.5)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
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
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, -9.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(ceil 9.1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 10.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(ceil 3)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(ceil 2.3 2.5)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `copysign` function
     */
    func testCopySign() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(copysign 5.0 -1.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, -5.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(copysign -5.0 1.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 5.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(copysign -5.0 -1.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, -5.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(copysign 5 -1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, -5)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(copysign -5 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 5)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(copysign 5.0 -1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, -5.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(copysign -5 1.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 5.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(copysign hello world)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(copysign -2 2 4)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `fabs` function
     */
    func testFabs() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(fabs -9.1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 9.1)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(fabs 9.1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 9.1)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(fabs -3)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(fabs 2.3 4.2)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `factorial` function
     */
    func testFactorial() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(factorial 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 1)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(factorial 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 1)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(factorial 1.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 1.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(factorial 10)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 3628800)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(factorial 10.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 3628800.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(factorial 20)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 2432902008176640000)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(factorial 20.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 2432902008176640000.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(factorial 100)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 9.33262154439441e+157)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(factorial two)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(factorial 2 4)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `floor` function
     */
    func testFloor() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(floor -9.1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, -10.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(floor 9.1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 9.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(floor 3)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(floor 2.3 2.5)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `fmod` function
     */
    func testFmod() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(fmod 3.0 2.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 1.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(fmod pi e)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.423310825130748)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(fmod e pi)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 2.7182818284590451)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(fmod 3 2)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(fmod 2.3)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `frexp` function
     */
    func testFrexp() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(frexp 3.0)")
            var result = try Interpreter.eval(parsed, with: &interpreter.globalEnv) as Any
            XCTAssertEqual(Interpreter.schemeString(&result), "(0.75 2)")
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(frexp pi)")
            var result = try Interpreter.eval(parsed, with: &interpreter.globalEnv) as Any
            let ref = Foundation.frexp(standardEnv["pi"] as! Double)

            /* We can't use a string literal for the expected result because
               the exact value returned by either frexp or
               String(describing:) the result can vary between swift
               versions or builds. */
            var refStr = "("
            refStr.append(String(describing: ref.0))
            refStr.append(" 2)")

            XCTAssertEqual(Interpreter.schemeString(&result), refStr)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(frexp e)")
            var result = try Interpreter.eval(parsed, with: &interpreter.globalEnv) as Any

            let ref = Foundation.frexp(standardEnv["e"] as! Double)

            var refStr = "("
            refStr.append(String(describing: ref.0))
            refStr.append(" 2)")

            XCTAssertEqual(Interpreter.schemeString(&result), refStr)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(frexp 3)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(frexp 2.3 2.5)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `fsum` function
     */
    func testFsum() {
        var parsed: Any
        
        do {
            parsed = try Interpreter.parse("(fsum (quote (1.0 2.0 3.0)))")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv) as Any
            XCTAssertEqual(result as? Double, 6.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(fsum (quote (-1.0 -2.0 3.0)))")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv) as Any
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(fsum (quote (1 2 3)))")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv) as Any
            XCTAssertEqual(result as? Int, 6)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(fsum (quote (-1 -2 3)))")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv) as Any
            XCTAssertEqual(result as? Int, 0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(fsum (3.0))")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(fsum (quote (-1.0 -2.0 3.0)) (quote (-1.0 -2.0 3.0)))")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `isinf` function
     */
    func testIsinf() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(isinf 92233720368547758.56346785346)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(isinf inf)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(isinf 92233720368547758)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(isinf 92233720368547758.56346785346 92233720368547758.56346785346)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `isnan` function
     */
    func testIsnan() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(isnan 92233720368547758.56346785346)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(isnan 92233720368547758)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, false)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(isnan hello)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Bool, true)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(isnan hello world)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `ldexp` function
     */
    func testLdexp() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(ldexp pi 2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 12.566370614359172)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(ldexp e 3)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 21.746254627672361)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(ldexp pi e)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(ldexp e 2 pi)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `trunc` function
     */
    func testTrunc() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(trunc pi)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 3.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(trunc e)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 2.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(trunc 1)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(trunc pi e)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `exp` function
     */
    func testExp() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(exp 0.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 1.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(exp 1.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 2.718281828459045)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(exp 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 1.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(exp 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 2.718281828459045)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(exp 1.0 0.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(exp 1 0.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(exp 1.0 0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
    Tests our `log` function
     */
    func testLog() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(log 1.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(log e)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 1.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(log 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(log 1.0 0.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(log 1.0 0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(log 1 0.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `log1p` function
     */
    func testLog1p() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(log1p 1.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.6931471805599453)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(log1p 0.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(log1p 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.6931471805599453)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(log1p 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(log1p 1.0 0.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(log1p 1.0 0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(log1p 1 0.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `log10` function
     */
    func testLog10() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(log10 1.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(log10 10.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 1.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(log10 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(log10 10)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 1.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(log10 1.0 0.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(log10 1 0.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(log10 1.0 0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `pow` function
     */
    func testPow() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(pow 1 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 1)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(pow 2 3)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 8)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(pow 2 3.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 8.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(pow 2.0 3)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 8.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(pow 2.0 3.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 8.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(pow 2)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `sqrt` function
     */
    func testSqrt() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(sqrt 16.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 4.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(sqrt 4.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 2.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(sqrt 16)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 4)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(sqrt 4)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Int, 2)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(sqrt 2.0 2.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `acos` function
     */
    func testAcos() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(acos 0.1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 1.47062890563334, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(acos 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(acos a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(acos 1.0 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `asin` function
     */
    func testAsin() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(asin 0.1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 0.10016742116156, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(asin 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(asin a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(asin 1.0 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `atan` function
     */
    func testAtan() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(atan 0.1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 0.099668652491162, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(atan 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(atan a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(atan 1.0 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `atan2` function
     */
    func testAtan2() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(atan2 1 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 0.785398163397448, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(atan2 0 0.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(atan2 0.0 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(atan2 0.1 2.2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 0.045423279421577, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(atan2 a b)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(atan2 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `cos` function
     */
    func testCos() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(cos 0.1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 0.995004165278026, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(cos 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 1.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(cos a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(cos 1.0 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `hypot` function
     */
    func testHypot() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(hypot 1 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 1.41421356237309, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(hypot 0 0.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(hypot 0.0 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(hypot 0.1 2.2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 2.20227155455452, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(hypot a b)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(hypot 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `sin` function
     */
    func testSin() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(sin 0.1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 0.0998334166468282, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(sin 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(sin a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(sin 1.0 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `tan` function
     */
    func testTan() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(tan 0.1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 0.100334672085451, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(tan 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(tan a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(tan 1.0 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `acosh` function
     */
    func testAcosh() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(acosh 1.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(acosh 2)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 1.3169578969248167, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(acosh a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(acosh 1.0 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `asinh` function
     */
    func testAsinh() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(asinh 0.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(asinh 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 0.881373587019543, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(asinh a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(asinh 1.0 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `atanh` function
     */
    func testAtanh() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(atanh 0.1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 0.100335347731075, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(atanh 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(atanh a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(atanh 1.0 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `cosh` function
     */
    func testCosh() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(cosh 0.1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 1.0050041680558035, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(cosh 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 1.5430806348152437, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(cosh a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(cosh 1.0 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `sinh` function
     */
    func testSinh() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(sinh 0.1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 0.1001667500198440, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(sinh 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 1.1752011936438014, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(sinh a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(sinh 1.0 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }

    /**
     Tests our `tanh` function
     */
    func testTanh() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(tanh 0.0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(tanh 0.1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 0.0996679946249558, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(tanh 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 0.7615941559557648, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(tanh a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(tanh 1.0 1.0)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }
    
    /**
     Tests our `degrees` function
     */
    func testDegrees() {
        var parsed: Any
        
        do {
            parsed = try Interpreter.parse("(degrees pi)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 180.0)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(degrees 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 0.0)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(degrees 1.5708)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 90.0002105, accuracy: 0.0000001)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(degrees a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(degrees pi pi)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }
    
    /**
     Tests our `radians` function
     */
    func testRadians() {
        var parsed: Any

        do {
            parsed = try Interpreter.parse("(radians 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0.0)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(radians 180)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, Double.pi, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(radians 90)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 1.5708, accuracy: 0.0001)
        } catch {
            XCTFail()
        }

        do {
            parsed = try Interpreter.parse("(radians a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }

        do {
            parsed = try Interpreter.parse("(radians 180 180")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }
    
    /**
     Tests our `erf` function
     */
    func testErf() {
        var parsed: Any
        
        do {
            parsed = try Interpreter.parse("(erf 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(erf 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 0.8427007929497148, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(erf a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(erf 0 1")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }
    
    /**
     Tests our `erfc` function
     */
    func testErfc() {
        var parsed: Any
        
        do {
            parsed = try Interpreter.parse("(erfc 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 1)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(erfc 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as! Double, 0.1572992070502851, accuracy: 0.0000000001)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(erfc a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(erfc 0 1")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }
    
    /**
     Tests our `gamma` function
     */
    func testGamma() {
        var parsed: Any
        
        do {
            parsed = try Interpreter.parse("(gamma 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, Double.infinity)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(gamma 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 1)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(gamma a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(gamma 0 1")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }
    
    /**
     Tests our `lgamma` function
     */
    func testLgamma() {
        var parsed: Any
        
        do {
            parsed = try Interpreter.parse("(lgamma 0)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, Double.infinity)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(lgamma 1)")
            let result = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, 0)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(lgamma a)")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(lgamma 0 1")
            let _ = try Interpreter.eval(parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }
}
