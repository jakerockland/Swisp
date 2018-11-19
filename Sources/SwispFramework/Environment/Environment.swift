//
//  Environment.swift
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

/// An environment with some Scheme standard procedures
public let standardEnv = Env([
    // Constants
    "π":        3.1415926535897932384626433832795,
    "pi":       3.1415926535897932384626433832795,
    "𝑒":        2.7182818284590452353602874713527,
    "e":        2.7182818284590452353602874713527,
    
    // Operators
    "+":        Operators.add,
    "-":        Operators.subtract,
    "*":        Operators.multiply,
    "/":        Operators.divide,
    "%":        Operators.mod,
    ">":        Operators.greaterThan,
    "<":        Operators.lessThan,
    ">=":       Operators.greaterThanEqual,
    "<=":       Operators.lessThanEqual,
    "=":        Operators.equal,
    
    // Number-theoretic and representation functions
    "ceil":     Math.ceil,
    "copysign": Math.copysign,
    "fabs":     Math.fabs,
    "factorial":Math.factorial,
    "floor":    Math.floor,
    "fmod":     Math.fmod,
    "frexp":    Math.frexp,
    "fsum":     Math.fsum,
    "isinf":    Math.isinf,
    "isnan":    Math.isnan,
    "ldexp":    Math.ldexp,
    "trunc":    Math.trunc,
    
    // Power and logarithmic functions
    "exp":      Math.exp,
    "log":      Math.log,
    "log1p":    Math.log1p,
    "log10":    Math.log10,
    "pow":      Math.pow,
    "sqrt":     Math.sqrt,
    
    // Trigonometric functions
    "acos":     Math.acos,
    "asin":     Math.asin,
    "atan":     Math.atan,
    "atan2":    Math.atan2,
    "cos":      Math.cos,
    "hypot":    Math.hypot,
    "sin":      Math.sin,
    "tan":      Math.tan,
    
    // Angular conversion
    //    "degrees": degrees,
    //    "radians": radians,
    
    // Hyperbolic functions
    "acosh":    Math.acosh,
    "asinh":    Math.asinh,
    "atanh":    Math.atanh,
    "cosh":     Math.cosh,
    "sinh":     Math.sinh,
    "tanh":     Math.tanh,
    
    //            // Special functions
    //            "erf":      erf,
    //            "erfc":     erfc,
    //            "gamma":    gamma,
    //            "lgamma":   lgamma,
    
    //            // Misc.
    "abs":      Library.abs,
    "append":   Library.append,
    //            // "apply": apply, // [TODO](https://www.drivenbycode.com/the-missing-apply-function-in-swift/)
    //            "begin":    { $0[-1] },
    "car":      Library.car,
    "cdr":      Library.cdr,
    //            "cons":     { [$0] + $1 },
    //            "eq?":      { $0 === $1 },
    //            "equal?":   { $0 == $1 },
    //            "length":   { $0.count },
    //            "list":     { List($0) },
    //            "list?":    { $0 is List },
    //            // "map":     map, // [TODO](https://www.weheartswift.com/higher-order-functions-map-filter-reduce-and-more/)
    //            "max":      max,
    //            "min":      min,
    "not":      Library.not,
    //            "null?":    { $0 == nil },
    //            "number?":  { $0 is Number },
    //            "procedure?": { String(type(of: $0)).containsString("->") },
    //            "round":   round,
    //            "symbol?":  { $0 is Symbol }
] as [Symbol: Any])
