//
//  InterpreterTests.swift
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

@testable import SwispFramework
import XCTest

/**
 Simple tests for a simple Scheme interpreter written in Swift
 */
public class InterpreterTests: XCTestCase {
    
    // MARK: - Constant Values
    
    /// Value of mathematical constant π
    let π = 3.1415926535897932384626433832795
    
    
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
        
        // Define some test values
        var parsed: Any
        
        parsed = try! Interpreter.parse("(define ten 10)")
        let _ = try! Interpreter.eval(&parsed, with: &interpreter.globalEnv)
        
        parsed = try! Interpreter.parse("(define pass pass)")
        let _ = try! Interpreter.eval(&parsed, with: &interpreter.globalEnv)
        
        parsed = try! Interpreter.parse("(define fail fail)")
        let _ = try! Interpreter.eval(&parsed, with: &interpreter.globalEnv)
    }
    
    
    // MARK: - Testing Methods
    
    /**
     Tests our parsing method
     */
    func testParse() {
        let expected = ["begin", ["define", "r", 10], ["*", "pi", ["*", "r", "r"]]] as [Any]
        let program = "(begin (define r 10) (* pi (* r r)))"
        
        var parsed: [Any] = []
        do {
            guard let _parsed = try Interpreter.parse(program) as? [Any] else {
                XCTFail()
                return
            }
            parsed = _parsed
        } catch {
            XCTFail()
        }
        
        for (a, b) in zip(expected, parsed) {
            
            if let _a = a as? Int, let _b = b as? Int {
                if _a != _b {
                    XCTFail()
                }
            } else if let _a = a as? Double, let _b = b as? Double {
                if _a != _b {
                    XCTFail()
                }
            } else if let _a = a as? String, let _b = b as? String {
                if _a != _b {
                    XCTFail()
                }
            } else if let _a = a as? [Any], let _b = b as? [Any] {
                for (c, d) in zip(_a, _b) {
                    if let _c = c as? Int, let _d = d as? Int {
                        if _c != _d {
                            XCTFail()
                        }
                    } else if let _c = c as? Double, let _d = d as? Double {
                        if _c != _d {
                            XCTFail()
                        }
                    } else if let _c = c as? String, let _d = d as? String {
                        if _c != _d {
                            XCTFail()
                        }
                    } else if let _c = c as? [Any], let _d = d as? [Any] {
                        for (e, f) in zip(_c, _d) {
                            if let _e = e as? Int, let _f = f as? Int {
                                if _e != _f {
                                    XCTFail()
                                }
                            } else if let _e = e as? Double, let _f = f as? Double {
                                if _e != _f {
                                    XCTFail()
                                }
                            } else if let _e = e as? String, let _f = f as? String {
                                if _e != _f {
                                    XCTFail()
                                }
                            } else {
                                XCTFail()
                            }
                        }
                    } else {
                        XCTFail()
                    }
                }
            } else {
                XCTFail()
            }
        }
    }
    
    /**
     Checks performance of our parsing method
     */
    func testParsePerformance() {
        let program = "(begin (define r 10) (* pi (* r r)))"
        measure {
            do {
                _ = try Interpreter.parse(program)
            } catch {
                XCTFail()
            }
        }
    }
    
    /**
     Tests our token generation method
     */
    func testTokenize() {
        let tokenized = ["(", "begin", "(", "define", "r", "10", ")", "(", "*", "pi", "(", "*", "r", "r", ")", ")", ")"]
        let program = "(begin (define r 10) (* pi (* r r)))"
        XCTAssertEqual(tokenized, Interpreter.tokenize(program))
    }
    
    /**
     Checks performance of our token generation method
     */
    func testTokenizePerformance() {
        let program = "(begin (define r 10) (* pi (* r r)))"
        measure {
            _ = Interpreter.tokenize(program)
        }
    }
    
    /**
     Tests our abstract syntax tree generation method
     */
    func testReadFromTokens() {
        var eof = Interpreter.tokenize("(")
        do {
            try _ = Interpreter.readFromTokens(&eof)
            XCTAssertTrue(false)
        } catch {
            XCTAssertTrue(true)
        }
        
        var unexpected = Interpreter.tokenize(")")
        do {
            try _ = Interpreter.readFromTokens(&unexpected)
            XCTAssertTrue(false)
        } catch {
            XCTAssertTrue(true)
        }
    }
    
    /**
     Tests our atomizer
     */
    func testAtom() {
        let int = "69"
        if let atom = Interpreter.atom(int) as? Int, atom == 69 {
            XCTAssertTrue(true)
        } else {
            XCTAssertTrue(false)
        }
        
        let float = "8.3066"
        if let atom = Interpreter.atom(float) as? Double, atom == 8.3066 {
            XCTAssertTrue(true)
        } else {
            XCTAssertTrue(false)
        }
        
        let symbol = "something"
        if let atom = Interpreter.atom(symbol) as? Symbol, atom == "something" {
            XCTAssertTrue(true)
        } else {
            XCTAssertTrue(false)
        }
    }
    
    /**
     Tests our evaluation function
     */
    func testEval() {
        var parsed: Any
        
        do {
            parsed = try Interpreter.parse("(ten)")
            let r = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(r as? Int, 10)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(* pi (* ten ten))")
            let result = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(result as? Double, π * 100)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(pass)")
            let pass = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(pass as? Symbol, "pass")
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(if (> 1 0) pass fail)")
            let greater = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(greater as? Symbol, "pass")
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(if (< 1 0) pass fail)")
            let less = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(less as? Symbol, "fail")
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(if (= 1 0) pass fail)")
            let equal = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(equal as? Symbol, "fail")
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(quote (+ 1 2))")
            var equal = try Interpreter.eval(&parsed, with: &interpreter.globalEnv) as Any
            XCTAssertEqual(Interpreter.schemeString(&equal), "(+ 1 2)")
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(quote (/ (+ 1 2) (* 3 4)))")
            var equal = try Interpreter.eval(&parsed, with: &interpreter.globalEnv) as Any
            XCTAssertEqual(Interpreter.schemeString(&equal), "(/ (+ 1 2) (* 3 4))")
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(define r 10)")
            let _ = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            parsed = try Interpreter.parse("(r)")
            let before = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(before as? Int, 10)
            
            parsed = try Interpreter.parse("(set! r (* r r))")
            let _ = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            parsed = try Interpreter.parse("(r)")
            let after = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(after as? Int, 100)
        } catch {
            XCTFail()
        }
        
        do {
            parsed = try Interpreter.parse("(define twice (lambda (x) (* 2 x)))")
            let _ = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            parsed = try Interpreter.parse("(twice 5)")
            let twice = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(twice as? Int, 10)
            
            parsed = try Interpreter.parse("(define repeat (lambda (f) (lambda (x) (f (f x)))))")
            let _ = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            parsed = try Interpreter.parse("((repeat twice) 10)")
            let repeatTwice = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(repeatTwice as? Int, 40)
            
            parsed = try Interpreter.parse("((repeat (repeat twice)) 10)")
            let repeatRepeatTwice = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(repeatRepeatTwice as? Int, 160)
            
            parsed = try Interpreter.parse("((repeat (repeat (repeat twice))) 10)")
            let repeatRepeatRepeatTwice = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTAssertEqual(repeatRepeatRepeatTwice as? Int, 2560)
        } catch {
            XCTFail()
        }
    }
    
    /**
     Tests proper errors being thrown by our evaluation function
    */
    func testEvalErrors() {
        var parsed: Any
        
        do {
            parsed = try Interpreter.parse("(quote)")
            let _ = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(if (+ 1 1))")
            let _ = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(if (+ 1 1) how what)")
            let _ = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(define 1 2)")
            let _ = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(set! 1 2)")
            let _ = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("(lambda x (* 2 x))")
            let _ = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
        
        do {
            parsed = try Interpreter.parse("()")
            let _ = try Interpreter.eval(&parsed, with: &interpreter.globalEnv)
            XCTFail()
        } catch {
            XCTPass()
        }
    }
    
    /**
     Tests performance of our evaluation function
     */
    func testEvalPerformance() {
        var parsed: Any = 0
        
        do {
            parsed = try Interpreter.parse("(* pi (* ten ten))")
        } catch {
            XCTFail()
        }
        
        measure {
            do {
                let _ = try Interpreter.eval(&parsed, with: &self.interpreter.globalEnv)
            } catch {
                XCTFail()
            }
        }
    }
    
}
