//
//  InterpreterTests.swift
//  SwispTests
//
//  Copyright (c) 2016 Jake Rockland (http://jakerockland.com)
//
//  Licensed under the Apache License, Version 2.0 (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

import XCTest

/**
 Simple tests for a simple Scheme interpreter written in Swift
 */
class InterpreterTests: XCTestCase {
    
    // MARK: - Testing Constants
    
    /// Value of mathematical constant π
    let π = 3.1415926535897932384626433832795

    /// Value of mathematical constant 𝑒
    let 𝑒 = 2.7182818284590452353602874713527
    
    // MARK: - Testing Properties
    
    var interpreter: Interpreter?
    
    // MARK: - Set Up Methods
    
    /**
     Called before every test method
     */
    override func setUp() {
        super.setUp()
        interpreter = Interpreter()
    }
    
    // MARK: - Testing Methods
    
    /**
     Tests our parsing method
     */
    func testParse() {
        let parsed = ["begin", ["define", "r", 10], ["*", "pi", ["*", "r", "r"]]] as [Any]
        let program = "(begin (define r 10) (* pi (* r r)))"
        for (a, b) in zip(parsed, Interpreter.parse(program)) {
            
            if let _a = a as? Int, let _b = b as? Int {
                if _a != _b {
                    XCTFail()
                }
            } else if let _a = a as? Float, let _b = b as? Float {
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
                    } else if let _c = c as? Float, let _d = d as? Float {
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
                            } else if let _e = e as? Float, let _f = f as? Float {
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
        self.measure {
            _ = Interpreter.parse(program)
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
        self.measure {
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
        if let atom = Interpreter.atom(float) as? Float, atom == 8.3066 {
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
     Tests our evalutaion function
     */
    func testEval() {
        let _ = Interpreter.eval(Interpreter.parse("(define r 10)"), withEnvironment: &interpreter!.globalEnv)
        let result = Interpreter.eval(Interpreter.parse("(* pi (* r r))"), withEnvironment: &interpreter!.globalEnv)
        XCTAssertEqual(result as? Double, π * 100)
    }
    
}
