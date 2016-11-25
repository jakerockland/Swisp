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

    // TODO: Make extendable to more comparable objects
    /**
     Static function for `>` operator
     */
    static func greaterThan(lhs: Any, rhs: Any) -> Bool {
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

    // TODO: Make extendable to more comparable objects
    /**
     Static function for `<` operator
     */
    static func lessThan(lhs: Any, rhs: Any) -> Bool {
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

    // TODO: Make extendable to more comparable objects
    /**
     Static function for `>=` operator
     */
    static func greaterThanEqual(lhs: Any, rhs: Any) -> Bool {
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

    // TODO: Make extendable to more comparable objects
    /**
     Static function for `<=` operator
     */
    static func lessThanEqual(lhs: Any, rhs: Any) -> Bool {
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

    // TODO: Make extendable to more comparable objects
    /**
     Static function for `=` operator
     */
    static func equal(lhs: Any, rhs: Any) -> Bool {
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

