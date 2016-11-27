//
//  Environment.swift
//  Swisp
//
//  Copyrhs (c) 2016 Jake Rockland (http://jakerockland.com)
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
struct Operators {

    /**
     Static function for `+` operator
     */
    static func add(lhs: Any, rhs: Any) -> Any {
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
            return 0
        }
    }

    /**
     Static function for `-` operator
     */
    static func subtract(lhs: Any, rhs: Any) -> Any {
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
            return 0
        }
    }

    /**
     Static function for `*` operator
     */
    static func multiply(lhs: Any, rhs: Any) -> Any {
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
            return 0
        }
    }

    /**
     Static function for `/` operator
     */
    static func divide(lhs: Any, rhs: Any) -> Any {
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
            return 0
        }
    }

    /**
     Static function for `>` operator
     */
    static func greaterThan(lhs: Any, rhs: Any) -> Any {
        switch (lhs, rhs) {
        case let (_lhs as Int, _rhs as Int):
            return _lhs > _rhs
        case let (_lhs as Double, _rhs as Double):
            return _lhs > _rhs
        case let (_lhs as String, _rhs as String):
            return _lhs > _rhs
        default:
            return false
        }
    }

    /**
     Static function for `<` operator
     */
    static func lessThan(lhs: Any, rhs: Any) -> Any {
        switch (lhs, rhs) {
        case let (_lhs as Int, _rhs as Int):
            return _lhs < _rhs
        case let (_lhs as Double, _rhs as Double):
            return _lhs < _rhs
        case let (_lhs as String, _rhs as String):
            return _lhs < _rhs
        default:
            return false
        }
    }

    /**
     Static function for `>=` operator
     */
    static func greaterThanEqual(lhs: Any, rhs: Any) -> Any {
        switch (lhs, rhs) {
        case let (_lhs as Int, _rhs as Int):
            return _lhs >= _rhs
        case let (_lhs as Double, _rhs as Double):
            return _lhs >= _rhs
        case let (_lhs as String, _rhs as String):
            return _lhs >= _rhs
        default:
            return false
        }
    }

    /**
     Static function for `<=` operator
     */
    static func lessThanEqual(lhs: Any, rhs: Any) -> Any {
        switch (lhs, rhs) {
        case let (_lhs as Int, _rhs as Int):
            return _lhs <= _rhs
        case let (_lhs as Double, _rhs as Double):
            return _lhs <= _rhs
        case let (_lhs as String, _rhs as String):
            return _lhs <= _rhs
        default:
            return false
        }
    }

    /**
     Static function for `=` operator
     */
    static func equal(lhs: Any, rhs: Any) -> Any {
        switch (lhs, rhs) {
        case let (_lhs as Int, _rhs as Int):
            return _lhs == _rhs
        case let (_lhs as Double, _rhs as Double):
            return _lhs == _rhs
        case let (_lhs as String, _rhs as String):
            return _lhs == _rhs
        default:
            return false
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
struct Library {

    /**
     Static function for `abs` operation
     */
    static func abs(val: Any) -> Any {
        switch (val) {
        case let (_val as Int):
            return Swift.abs(_val)
        case let (_val as Double):
            return Swift.abs(_val)
        default:
            return 0
        }
    }

    // TODO: Needs testing!
    /**
     Static function for `car` operation
     */
    static func car(lis: Any) -> Any {
        guard let _lis = lis as? [Any] else {
            return []
        }

        return _lis.first ?? []
    }

    // TODO: Needs testing!
    /**
     Static function for `cdr` operation
     */
    static func cdr(lis: Any) -> Any {
        guard let _lis = lis as? [Any] else {
            return []
        }

        return _lis.first ?? []
    }

}

/**
 Provides the following basic math operations as static functions:
- `ceil`
 "copysign": copysign,
 "fabs":     fabs,
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
struct Math {

    /**
     Static function for `ceil` operation
     */
    static func ceil(val: Any) -> Any {
        switch (val) {
        case let (_val as Double):
            return Foundation.ceil(_val)
        default:
            return 0
        }
    }

    /**
     Static function for `floor` operation
     */
    static func floor(val: Any) -> Any {
        switch (val) {
        case let (_val as Double):
            return Foundation.floor(_val)
        default:
            return 0
        }
    }

    /**
     Static function for `copysign` operation
     */
    static func copysign(lhs: Any, rhs: Any) -> Any {
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
            return 0
        }
    }
    
}
