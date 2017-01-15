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
    static func add(lhs: Any, rhs: Any) -> Any? {
        switch (lhs, rhs) {
        case let (_lhs as String, _rhs as String):
            return _lhs + _rhs
        case let (_lhs as Int, _rhs as Int):
            return _lhs + _rhs
        case let (_lhs as Double, _rhs as Double):
            return _lhs + _rhs
        case let (_lhs as Int, _rhs as Double):
            return Double(_lhs) + _rhs
        case let (_lhs as Double, _rhs as Int):
            return _lhs + Double(_rhs)
        default:
            return nil
        }
    }

    /**
     Static function for `-` operator
     */
    static func subtract(lhs: Any, rhs: Any) -> Any? {
        switch (lhs, rhs) {
        case let (_lhs as Int, _rhs as Int):
            return _lhs - _rhs
        case let (_lhs as Double, _rhs as Double):
            return _lhs - _rhs
        case let (_lhs as Int, _rhs as Double):
            return Double(_lhs) - _rhs
        case let (_lhs as Double, _rhs as Int):
            return _lhs - Double(_rhs)
        default:
            return nil
        }
    }

    /**
     Static function for `*` operator
     */
    static func multiply(lhs: Any, rhs: Any) -> Any? {
        switch (lhs, rhs) {
        case let (_lhs as Int, _rhs as Int):
            return _lhs * _rhs
        case let (_lhs as Double, _rhs as Double):
            return _lhs * _rhs
        case let (_lhs as Int, _rhs as Double):
            return Double(_lhs) * _rhs
        case let (_lhs as Double, _rhs as Int):
            return _lhs * Double(_rhs)
        default:
            return nil
        }
    }

    /**
     Static function for `/` operator
     */
    static func divide(lhs: Any, rhs: Any) -> Any? {
        switch (lhs, rhs) {
        case let (_lhs as Int, _rhs as Int):
            return _lhs / _rhs
        case let (_lhs as Double, _rhs as Double):
            return _lhs / _rhs
        case let (_lhs as Int, _rhs as Double):
            return Double(_lhs) / _rhs
        case let (_lhs as Double, _rhs as Int):
            return _lhs / Double(_rhs)
        default:
            return nil
        }
    }

    /**
     Static function for `%` operator
     */
    static func mod(lhs: Any, rhs: Any) -> Any? {
        switch (lhs, rhs) {
        case let (_lhs as Int, _rhs as Int):
            return _lhs % _rhs
        default:
            return nil
        }
    }

    /**
     Static function for `>` operator
     */
    static func greaterThan(lhs: Any, rhs: Any) -> Any? {
        switch (lhs, rhs) {
        case let (_lhs as Int, _rhs as Int):
            return _lhs > _rhs
        case let (_lhs as Double, _rhs as Double):
            return _lhs > _rhs
        case let (_lhs as String, _rhs as String):
            return _lhs > _rhs
        default:
            return nil
        }
    }

    /**
     Static function for `<` operator
     */
    static func lessThan(lhs: Any, rhs: Any) -> Any? {
        switch (lhs, rhs) {
        case let (_lhs as Int, _rhs as Int):
            return _lhs < _rhs
        case let (_lhs as Double, _rhs as Double):
            return _lhs < _rhs
        case let (_lhs as String, _rhs as String):
            return _lhs < _rhs
        default:
            return nil
        }
    }

    /**
     Static function for `>=` operator
     */
    static func greaterThanEqual(lhs: Any, rhs: Any) -> Any? {
        switch (lhs, rhs) {
        case let (_lhs as Int, _rhs as Int):
            return _lhs >= _rhs
        case let (_lhs as Double, _rhs as Double):
            return _lhs >= _rhs
        case let (_lhs as String, _rhs as String):
            return _lhs >= _rhs
        default:
            return nil
        }
    }

    /**
     Static function for `<=` operator
     */
    static func lessThanEqual(lhs: Any, rhs: Any) -> Any? {
        switch (lhs, rhs) {
        case let (_lhs as Int, _rhs as Int):
            return _lhs <= _rhs
        case let (_lhs as Double, _rhs as Double):
            return _lhs <= _rhs
        case let (_lhs as String, _rhs as String):
            return _lhs <= _rhs
        default:
            return nil
        }
    }

    /**
     Static function for `=` operator
     */
    static func equal(lhs: Any, rhs: Any) -> Any? {
        switch (lhs, rhs) {
        case let (_lhs as Int, _rhs as Int):
            return _lhs == _rhs
        case let (_lhs as Double, _rhs as Double):
            return _lhs == _rhs
        case let (_lhs as String, _rhs as String):
            return _lhs == _rhs
        default:
            return nil
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
    static func abs(val: Any) -> Any? {
        switch (val) {
        case let (_val as Int):
            return Swift.abs(_val)
        case let (_val as Double):
            return Swift.abs(_val)
        default:
            return nil
        }
    }
    
    /**
     Static function for `append` operation
     */
    static func append(lis1: Any, lis2: Any) -> Any? {
        guard let _lis1 = lis1 as? [Any], let _lis2 = lis2 as? [Any] else {
            return nil
        }
        return _lis1 + _lis2
    }

    /**
     Static function for `car` operation
     */
    static func car(lis: Any) -> Any? {
        guard let _lis = lis as? [Any] else {
            return nil
        }
        return _lis.first
    }

    /**
     Static function for `cdr` operation
     */
    static func cdr(lis: Any) -> Any? {
        guard let _lis = lis as? [Any] else {
            return nil
        }
        return Array(_lis.dropFirst())
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
    static func ceil(val: Any) -> Any? {
        switch (val) {
        case let (_val as Double):
            return Foundation.ceil(_val)
        default:
            return nil
        }
    }

    /**
     Static function for `copysign` operation
     */
    static func copysign(lhs: Any, rhs: Any) -> Any? {
        switch (lhs, rhs) {
        case let (_lhs as Double, _rhs as Double):
            return Foundation.copysign(_lhs, _rhs)
        case let (_lhs as Int, _rhs as Int):
            return Int(Foundation.copysign(Double(_lhs), Double(_rhs)))
        case let (_lhs as Int, _rhs as Double):
            return Foundation.copysign(Double(_lhs), _rhs)
        case let (_lhs as Double, _rhs as Int):
            return Foundation.copysign(_lhs, Double(_rhs))
        default:
            return nil
        }
    }

    /**
     Static function for `fabs` operation
     */
    static func fabs(val: Any) -> Any? {
        switch (val) {
        case let (_val as Double):
            return Foundation.fabs(_val)
        default:
            return nil
        }
    }
    
    /**
     Static function for `factorial` operation
     */
    static func factorial(val: Any) -> Any? {
        switch (val) {
        case let (_val as Int):
            if _val > 20 {
                return nil
            } else if _val == 0 {
                return 1
            } else {
                return _val * (factorial(val: _val - 1) as! Int)
            }
        default:
            return nil
        }
    }

    /**
     Static function for `floor` operation
     */
    static func floor(val: Any) -> Any? {
        switch (val) {
        case let (_val as Double):
            return Foundation.floor(_val)
        default:
            return nil
        }
    }
    
    /**
     Static function for `fmod` operation
     */
    static func fmod(lhs: Any, rhs: Any) -> Any? {
        switch (lhs, rhs) {
        case let (_lhs as Double, _rhs as Double):
            return Foundation.fmod(_lhs, _rhs)
        default:
            return nil
        }
    }
    
    /**
     Static function for `frexp` operation
     */
    static func frexp(val: Any) -> Any? {
        switch (val) {
        case let (_val as Double):
            let temp = Foundation.frexp(_val)
            return [temp.0, temp.1]
        default:
            return nil
        }
    }
    
    /**
     Static function for `fsum` operation
     */
    static func fsum(val: Any) -> Any? {
        switch (val) {
        case let (_val as [Double]):
            return _val.reduce(0,+)
        case let (_val as [Int]):
            return _val.reduce(0,+)
        default:
            return nil
        }
    }
    
    /**
     Static function for `isinf` operation
     */
    static func isinf(val: Any) -> Any? {
        switch (val) {
        case let (_val as Double):
            return _val >= Double.infinity
        default:
            return nil
        }
    }
    
    /**
     Static function for `isinf` operation
     */
    static func isnan(val: Any) -> Any? {
        switch (val) {
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
    static func ldexp(val: Any, exp: Any) -> Any? {
        switch (val, exp) {
        case let (_val as Double, _exp as Int):
            return Foundation.ldexp(_val, _exp)
        default:
            return nil
        }
    }
    
    /**
     Static function for `trunc` operation
     */
    static func trunc(val: Any) -> Any? {
        switch (val) {
        case let (_val as Double):
            return Foundation.trunc(_val)
        default:
            return nil
        }
    }
    
    /**
    Static function for `exp` operation 
    */
    static func exp(val: Any) -> Any? {
        switch (val) {
        case let (_val as Double):
            return Foundation.exp(_val)
        default:
            return nil
        }
    }
    
    /**
     Static function for `log` operation
     */
    static func log(val: Any) -> Any? {
        switch (val) {
        case let (_val as Double):
            return Foundation.log(_val)
        default:
            return nil
        }
    }

    /**
     Static function for `log1p` operation
     */
    static func log1p(val: Any) -> Any? {
        switch (val) {
        case let (_val as Double):
            return Foundation.log1p(_val)
        default:
            return nil
        }
    }
    
    /**
     Static function for `log10` operation
     */
    static func log10(val: Any) -> Any? {
        switch (val) {
        case let (_val as Double):
            return Foundation.log10(_val)
        default:
            return nil
        }
    }
    
    /**
     Static function for `pow` operation
     */
    static func pow(val: Any, exp: Any) -> Any? {
        switch (val, exp) {
        case let (_val as Double, _exp as Double):
            return Foundation.pow(_val, _exp)
        default:
            return nil
        }
    }

    /**
     Static function for `sqrt` operation
     */
    static func sqrt(val: Any) -> Any? {
        switch (val) {
        case let (_val as Double):
            return Foundation.sqrt(_val)
        default:
            return nil
        }
    }

}
