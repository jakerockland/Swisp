//
//  Environment.swift
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
    //            // Trigonometric functions
    //            "acos":     acos,
    //            "asin":     asin,
    //            "atan":     atan,
    //            "atan2":    atan2,
    //            "cos":      cos,
    //            "hypot":    hypot,
    //            "sin":      sin,
    //            "tan":      tan,
    //            // Angular conversion
    //            "degrees": degrees,
    //            "radians": radians,
    //            // Hyperbolic functions
    //            "acosh":    acosh,
    //            "asinh":    asinh,
    //            "atanh":    atanh,
    //            "cosh":     cosh,
    //            "sinh":     sinh,
    //            "tanh":     tanh,
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
    //            "not":      { !$0 },
    //            "null?":    { $0 == nil },
    //            "number?":  { $0 is Number },
    //            "procedure?": { String(type(of: $0)).containsString("->") },
    //            "round":   round,
    //            "symbol?":  { $0 is Symbol }
] as [Symbol: Any])

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
private struct Operators {

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
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
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
 //            "not":      { !$0 },
 //            "null?":    { $0 == nil },
 //            "number?":  { $0 is Number },
 //            "procedure?": { String(type(of: $0)).containsString("->") },
 //            "round":   round,
 //            "symbol?":  { $0 is Symbol }
 */
private struct Library {

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

}

/**
 Provides the following basic math operations as static functions:
- `ceil`
- `copysign`
- `fabs`
- `factorial`
- `floor`
- `fmod`
- `frexp`
- `fsum`
- `isinf`
- `isnan`
- `ldexp`
- `trunc`
- `exp`
- `log`
 - 'log1p'
 -'log10'
 -'exp'
 -'sqrt'
 */
private struct Math {

    /**
     Static function for `ceil` operation
     */
    static func ceil(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.ceil(val)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }

    /**
     Static function for `copysign` operation
     */
    static func copysign(_ args: [Any]) throws -> Any? {
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0], args[safe: 1]) {
        case let (lhs as Double, rhs as Double):
            return Foundation.copysign(lhs, rhs)
        case let (lhs as Int, rhs as Int):
            return Int(Foundation.copysign(Double(lhs), Double(rhs)))
        case let (lhs as Int, rhs as Double):
            return Foundation.copysign(Double(lhs), rhs)
        case let (lhs as Double, rhs as Int):
            return Foundation.copysign(lhs, Double(rhs))
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }

    /**
     Static function for `fabs` operation
     */
    static func fabs(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.fabs(val)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `factorial` operation
     */
    static func factorial(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Int):
            if val == 0 {
                return 1
            } else {
                let fact = try factorial([val - 1])
                switch (fact) {
                case let (_fact as Int):
                    let double = Double(val) * Double(_fact)
                    if double < Double(Int.max) && double > Double(-Int.max){
                        return Int(double)
                    } else {
                        return double
                    }
                case let (_fact as Double):
                    return Double(val) * _fact
                default:
                    throw SwispError.SyntaxError(message: "invalid procedure input")
                }
            }
        case let (val as Double):
            if val == 0.0 {
                return 1.0
            } else {
                let fact = try factorial([val - 1])
                switch (fact) {
                case let (_fact as Double):
                    return val * _fact
                default:
                    throw SwispError.SyntaxError(message: "invalid procedure input")
                }
            }
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }

    /**
     Static function for `floor` operation
     */
    static func floor(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.floor(val)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `fmod` operation
     */
    static func fmod(_ args: [Any]) throws -> Any? {
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0], args[safe: 1]) {
        case let (lhs as Double, rhs as Double):
            return Foundation.fmod(lhs, rhs)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `frexp` operation
     */
    static func frexp(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            let temp = Foundation.frexp(val)
            return [temp.0, temp.1]
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `fsum` operation
     */
    static func fsum(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as [Double]):
            return val.reduce(0,+)
        case let (val as [Int]):
            return val.reduce(0,+)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `isinf` operation
     */
    static func isinf(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return val >= Double.infinity
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `isinf` operation
     */
    static func isnan(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case (_ as Double):
            return false
        case (_ as Int):
            return false
        default:
            return true
        }
    }
    
    /**
     Static function for `ldexp` operation
     */
    static func ldexp(_ args: [Any]) throws -> Any? {
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0], args[safe: 1]) {
        case let (val as Double, exp as Int):
            return Foundation.ldexp(val, exp)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `trunc` operation
     */
    static func trunc(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.trunc(val)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
    Static function for `exp` operation 
    */
    static func exp(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.exp(val)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `log` operation
     */
    static func log(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.log(val)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }

    /**
     Static function for `log1p` operation
     */
    static func log1p(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.log1p(val)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `log10` operation
     */
    static func log10(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.log10(val)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `pow` operation
     */
    static func pow(_ args: [Any]) throws -> Any? {
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0], args[safe: 1]) {
        case let (val as Double, exp as Double):
            return Foundation.pow(val, exp)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }

    /**
     Static function for `sqrt` operation
     */
    static func sqrt(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.sqrt(val)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }

}
