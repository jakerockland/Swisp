//
//  Environment.swift
//  Swisp
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
 //            "append":   { $0 + $1 },
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
internal struct Library {

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

    // TODO: Needs testing!
    /**
     Static function for `car` operation
     */
    static func car(lis: Any) -> Any? {
        let _lis = lis as? [Any]
        return _lis?.first
    }

    // TODO: Needs testing!
    /**
     Static function for `cdr` operation
     */
    static func cdr(lis: Any) -> Any? {
        let _lis = lis as? [Any]
        return _lis?.dropFirst()
    }

}

/**
 Provides the following basic math operations as static functions:
- `ceil`
- `copysign`
-  `fabs`
 // "factorial": factorial, // TODO
- `floor`
 "fmod":     fmod,
 "frexp":    frexp,
 // "fsum": fsum, // TODO
 "isinf":    isinf,
 "isnan":    isnan,
 "ldexp":    ldexp,
 "trunc":    trunc,
 */
internal struct Math {

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
    
}
