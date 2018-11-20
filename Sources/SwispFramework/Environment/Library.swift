//
//  Library.swift
//  SwispFramework
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

import Foundation

/**
 Provides the following basic library operations as static functions:
 - `abs`
 - `append`
 //            // "apply": apply, // [TODO](https://www.drivenbycode.com/the-missing-apply-function-in-swift/)
 //            "begin":    { $0[-1] },
 - `car`
 - `cdr`
 //            "cons":     { [$0] + $1 },
 //            "eq?":      { $0 === $1 },
 //            "equal?":   { $0 == $1 },
 //            "length":   { $0.count },
 //            "list":     { List($0) },
 //            "list?":    { $0 is List },
 //            // "map":     map, // [TODO](https://www.weheartswift.com/higher-order-functions-map-filter-reduce-and-more/)
 //            "max":      max,
 //            "min":      min,
 - `not`
 //            "null?":    { $0 == nil },
 //            "number?":  { $0 is Number },
 //            "procedure?": { String(type(of: $0)).containsString("->") },
 //            "round":   round,
 //            "symbol?":  { $0 is Symbol }
 */
internal struct Library {
    
    /**
     Static function for `abs` operation
     */
    static func abs(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Int):
            return Swift.abs(val)
        case let (val as Double):
            return Swift.abs(val)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `append` operation
     */
    static func append(_ args: [Any]) throws -> Any? {
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        guard let lis1 = args[safe: 0] as? [Any], let lis2 = args[safe: 1] as? [Any] else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        return lis1 + lis2
    }
    
    /**
     Static function for `car` operation
     */
    static func car(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        guard let lis = args[safe: 0] as? [Any] else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        return lis.first
    }
    
    /**
     Static function for `cdr` operation
     */
    static func cdr(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        guard let lis = args[safe: 0] as? [Any] else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        return Array(lis.dropFirst())
    }
    
    /**
     Static function for `not` operation
     */
    static func not(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Bool):
            return !val
        case let (val as NSNumber):
            return !Bool(truncating: val)
        case let (val as String):
            if let bool = Bool(val) {
                return !bool
            } else {
                throw SwispError.SyntaxError(message: "invalid procedure input")
            }
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
}
