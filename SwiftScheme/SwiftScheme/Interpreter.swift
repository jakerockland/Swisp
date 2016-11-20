//
//  Interpreter.swift
//  SwiftScheme
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

import Foundation

/// A Scheme Symbol is implemented as a Swift `String`
typealias Symbol = String

/// A Scheme List is implemented as a Swift `Any` array
typealias List = [Any]

/// A Scheme Number is implemented as a Swift `Int` or `Float`
typealias Number = (Int, Float)

/**
 A simple Scheme interpreter written in Swift
 */
class Interpreter {
    
    // MARK: - Error Definitions
    
    // TODO: Add block comment
    enum InterpreterError: Error {
        case SyntaxError(_: String)
    }
    
    // MARK: - Parser Methods
    
    /**
     Numbers become numbers; every other token is a symbol.
     
     - Parameter program: The text content of the program to be parsed.
     
     - Returns: The abstract syntax tree of the associated program.
     */
    static func parse(_ program: String) -> [Any] {
        var tokens = tokenize(program)
        return try! readFromTokens(&tokens) as! [Any]
    }
    
    /**
     Converts a string of characters into an array of tokens.
     
     - Parameter string: The `String` that we are tokenizing.
     
     - Returns: A `String` array containing the generated tokens.
     */
    static func tokenize(_ string: String) -> [String] {
        var tokens: [String] = []
        var temp: String = ""
        
        let whitespace: [Character] = [" ", "\n", "\t", "\r"]
        let padded = string.replacingOccurrences(of: "(", with: " ( ").replacingOccurrences(of: ")", with: " ) ")
        
        for char in padded.characters {
            if whitespace.contains(char) {
                if temp != "" {
                    tokens.append(temp)
                    temp = ""
                }
            } else {
                temp.append(char)
            }
        }
        
        return tokens
    }
    
    /**
     Read an expression from a sequence of tokens.
     
     - Parameter tokens: The `String` array containing a sequence of tokens.
     
     - Returns: A nested array representation of the corresponding abstract syntax tree.
     */
    static func readFromTokens(_ tokens: inout [String]) throws -> Any {        
        if tokens.count == 0 {
            throw InterpreterError.SyntaxError("unexpected EOF while reading")
        }
        
        let token = tokens.removeFirst()
        if token == "(" {
            var list: [Any] = []
            while tokens.first != ")" {
                try list.append(readFromTokens(&tokens))
            }
            tokens.removeFirst() // pop the corresponding ")"
            return list
        } else if token == ")" {
            throw InterpreterError.SyntaxError("unexpected )")
        } else {
            return atom(token)
        }
    }
    
    /**
     Numbers become numbers; every other token is left as a `String`.
     
     - Parameter token: TODO
     
     - Returns: TODO
     */
    static func atom(_ token: String) -> Any {
        if let int = Int(token) {
            return int
        } else if let float = Float(token) {
            return float
        } else {
            return token as Symbol
        }
        
    }
    
    // MARK: - Environment Methods

}
