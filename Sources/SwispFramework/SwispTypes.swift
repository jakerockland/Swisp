//
//  SwispTypes.swift
//  SwispFramework
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

/// A Scheme Symbol is implemented as a Swift `String`
public typealias Symbol = String

/// A Scheme List is implemented as a Swift `[Any]` array
public typealias List = [Any]

/// A Scheme Number is implemented as a custom Swift enum that wraps `Int` and `Double`
public enum Number {
    case Int
    case Double
}

/// A Scheme Env is implemented as a custom Swift class that wraps `Dictionary`
public class Env {
    
    /// Private dictionary representing environment's contents
    private var elements: [Symbol: Any]
    
    /// Private outer environment, if any
    private var outer: Env?
    
    /// Initializes a new environment with given dictionary
    public init(_ elements: [Symbol: Any] = [:], outer: Env? = nil) {
        self.elements = elements
        self.outer = outer
    }
    
    /// Initializes a new environment with given parameters and arguments
    public init(_ parms: [Symbol], _ args: [Any], outer: Env? = nil) {
        self.elements = [:]
        self.outer = outer
    }
    
    /// Gets value corresponding to given key, if any
    public subscript(_ key: Symbol) -> Any? {
        get {
            return elements[key]
        }
        set {
            elements[key] = newValue
        }
    }
    
    /// Find the innermost Env where `element` appears
    public func find(_ key: Symbol) -> Env? {
        return (elements[key] != nil) ? self : outer?.find(key)
    }
    
}
