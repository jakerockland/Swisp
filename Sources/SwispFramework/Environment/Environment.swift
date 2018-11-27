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

/// An environment with some Scheme standard procedures
public let standardEnv = Env([
    // Constants
    "π":        Double.pi,
    "pi":       Double.pi,
    "𝑒":        Double.e,
    "e":        Double.e,
    
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
    "degrees":  Math.degrees,
    "radians":  Math.radians,
    
    // Hyperbolic functions
    "acosh":    Math.acosh,
    "asinh":    Math.asinh,
    "atanh":    Math.atanh,
    "cosh":     Math.cosh,
    "sinh":     Math.sinh,
    "tanh":     Math.tanh,
    
    // Special functions
    "erf":      Math.erf,
    "erfc":     Math.erfc,
    "gamma":    Math.gamma,
    "lgamma":   Math.lgamma,
    
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
    "length":   Library.length,
    "list":     Library.list,
    "list?":    Library.isList,
    //            // "map":     map, // [TODO](https://www.weheartswift.com/higher-order-functions-map-filter-reduce-and-more/)
    "max":      Library.max,
    "min":      Library.min,
    "not":      Library.not,
    //            "null?":    { $0 == nil },
    "number?":  Library.isNumber,
    //            "procedure?": { String(type(of: $0)).containsString("->") },
    "round":    Library.round,
    //            "symbol?":  { $0 is Symbol }
] as [Symbol: Any])
