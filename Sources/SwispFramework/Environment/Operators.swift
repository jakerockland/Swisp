//
//  Operators.swift
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
 Provides the following basic operators as static functions:
 - `+`
 - `-`
 - `*`
 - `/`
 - `>`
 - `<`
 - `>=`
 - `<=`
 - `=`
 */
internal struct Operators {
    
    /**
     Static function for `+` operator
     */
    static func add(_ args: [Any]) throws -> Any? {
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0], args[safe: 1]) {
        case let (lhs as Int, rhs as Int):
            let double = Double(lhs) + Double(rhs)
            if double < Double(Int.max) && double > Double(-Int.max){
                return Int(double)
            } else {
                return double
            }
        case let (lhs as Double, rhs as Double):
            return lhs + rhs
        case let (lhs as Int, rhs as Double):
            return Double(lhs) + rhs
        case let (lhs as Double, rhs as Int):
            return lhs + Double(rhs)
        case let (lhs as String, rhs as String):
            return lhs + rhs
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `-` operator
     */
    static func subtract(_ args: [Any]) throws -> Any? {
        if args.count == 1 {
            switch (args[safe: 0]) {
            case let (val as Int):
                return -val
            case let (val as Double):
                return -val
            default:
                throw SwispError.SyntaxError(message: "invalid procedure input")
            }
        } else if args.count == 2 {
            switch (args[safe: 0], args[safe: 1]) {
            case let (lhs as Int, rhs as Int):
                let double = Double(lhs) - Double(rhs)
                if double < Double(Int.max) && double > Double(-Int.max){
                    return Int(double)
                } else {
                    return double
                }
            case let (lhs as Double, rhs as Double):
                return lhs - rhs
            case let (lhs as Int, rhs as Double):
                return Double(lhs) - rhs
            case let (lhs as Double, rhs as Int):
                return lhs - Double(rhs)
            default:
                throw SwispError.SyntaxError(message: "invalid procedure input")
            }
        } else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `*` operator
     */
    static func multiply(_ args: [Any]) throws -> Any? {
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0], args[safe: 1]) {
        case let (lhs as Int, rhs as Int):
            let double = Double(lhs) * Double(rhs)
            if double < Double(Int.max) && double > Double(-Int.max){
                return Int(double)
            } else {
                return double
            }
        case let (lhs as Double, rhs as Double):
            return lhs * rhs
        case let (lhs as Int, rhs as Double):
            return Double(lhs) * rhs
        case let (lhs as Double, rhs as Int):
            return lhs * Double(rhs)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `/` operator
     */
    static func divide(_ args: [Any]) throws -> Any? {
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0], args[safe: 1]) {
        case let (lhs as Int, rhs as Int):
            return lhs / rhs
        case let (lhs as Double, rhs as Double):
            return lhs / rhs
        case let (lhs as Int, rhs as Double):
            return Double(lhs) / rhs
        case let (lhs as Double, rhs as Int):
            return lhs / Double(rhs)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `%` operator
     */
    static func mod(_ args: [Any]) throws -> Any? {
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0], args[safe: 1]) {
        case let (lhs as Int, rhs as Int):
            return lhs % rhs
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `>` operator
     */
    static func greaterThan(_ args: [Any]) throws -> Any? {
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0], args[safe: 1]) {
        case let (lhs as Int, rhs as Int):
            return lhs > rhs
        case let (lhs as Double, rhs as Double):
            return lhs > rhs
        case let (lhs as String, rhs as String):
            return lhs > rhs
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `<` operator
     */
    static func lessThan(_ args: [Any]) throws -> Any? {
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0], args[safe: 1]) {
        case let (lhs as Int, rhs as Int):
            return lhs < rhs
        case let (lhs as Double, rhs as Double):
            return lhs < rhs
        case let (lhs as String, rhs as String):
            return lhs < rhs
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `>=` operator
     */
    static func greaterThanEqual(_ args: [Any]) throws -> Any? {
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0], args[safe: 1]) {
        case let (lhs as Int, rhs as Int):
            return lhs >= rhs
        case let (lhs as Double, rhs as Double):
            return lhs >= rhs
        case let (lhs as String, rhs as String):
            return lhs >= rhs
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `<=` operator
     */
    static func lessThanEqual(_ args: [Any]) throws -> Any? {
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0], args[safe: 1]) {
        case let (lhs as Int, rhs as Int):
            return lhs <= rhs
        case let (lhs as Double, rhs as Double):
            return lhs <= rhs
        case let (lhs as String, rhs as String):
            return lhs <= rhs
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `=` operator
     */
    static func equal(_ args: [Any]) throws -> Any? {
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0], args[safe: 1]) {
        case let (lhs as Int, rhs as Int):
            return lhs == rhs
        case let (lhs as Double, rhs as Double):
            return lhs == rhs
        case let (lhs as String, rhs as String):
            return lhs == rhs
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
}
