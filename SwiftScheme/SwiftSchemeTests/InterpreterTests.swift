//
//  InterpreterTests.swift
//  SwiftSchemeTests
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

// TODO: Add block comment
class InterpreterTests: XCTestCase {
    
    // TODO: Add block comment
    func testTokenize() {
        let tokenized = ["(", "begin", "(", "define", "r", "10", ")", "(", "*", "pi", "(", "*", "r", "r", ")", ")", ")"]
        let program = "(begin (define r 10) (* pi (* r r)))"
        XCTAssertEqual(tokenized, Interpreter.tokenize(program))
    }
    
    // TODO: Add block comment
    func testTokenizePerformance() {
        let program = "(begin (define r 10) (* pi (* r r)))"
        self.measure {
            _ = Interpreter.tokenize(program)
        }
    }
    
    func testParse() {
        let parsed = ["begin", ["define", "r", 10], ["*", "pi", ["*", "r", "r"]]] as [Any]
//        let program = "(begin (define r 10) (* pi (* r r)))"
        let program = "(())"
        for (a, b) in zip(parsed, Interpreter.parse(program)) {
            
            if let _a = a as? Int, let _b = b as? Int {
                if _a != _b {
                    XCTFail()
                }
            }
            else if let _a = a as? Float, let _b = b as? Float {
                if _a != _b {
                    XCTFail()
                }
            }
            else if let _a = a as? String, let _b = b as? String {
                if _a != _b {
                    XCTFail()
                }
            }
            else {
                // not a type we expected
                XCTFail()
            }
        }
    }
    
}
