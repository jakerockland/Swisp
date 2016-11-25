//
//  Environment.swift
//  Swisp
//
//  Copyright (c) 2016 Jake Rockland (http://jakerockland.com)
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
    static func add(left: Any, right: Any) -> Any {
        switch (left, right) {
        case let (first as String, second as String):
            return first + second
        case let (first as Int, second as Int):
            return first + second
        case let (first as Double, second as Double):
            return first + second
        case let (first as Int, second as Double):
            return Double(first) + second
        case let (first as Double, second as Int):
            return first + Double(second)
        default:
            return 0
        }
    }

    /**
     Static function for `-` operator
     */
    static func subtract(left: Any, right: Any) -> Any {
        switch (left, right) {
        case let (first as Int, second as Int):
            return first - second
        case let (first as Double, second as Double):
            return first - second
        case let (first as Int, second as Double):
            return Double(first) - second
        case let (first as Double, second as Int):
            return first - Double(second)
        default:
            return 0
        }
    }

    /**
     Static function for `/` operator
     */
    static func divide(left: Any, right: Any) -> Any {
        switch (left, right) {
        case let (first as Int, second as Int):
            return first / second
        case let (first as Double, second as Double):
            return first / second
        case let (first as Int, second as Double):
            return Double(first) / second
        case let (first as Double, second as Int):
            return first / Double(second)
        default:
            return 0
        }
    }

    /**
     Static function for `*` operator
     */
    static func multiply(left: Any, right: Any) -> Any {
        switch (left, right) {
        case let (first as Int, second as Int):
            return first * second
        case let (first as Double, second as Double):
            return first * second
        case let (first as Int, second as Double):
            return Double(first) * second
        case let (first as Double, second as Int):
            return first * Double(second)
        default:
            return 0
        }
    }

    // TODO: Make extendable to more comparable objects
    /**
     Static function for `>` operator
     */
    static func greaterThan(left: Any, right: Any) -> Bool {
        switch (left, right) {
        case let (first as Int, second as Int):
            return first > second
        case let (first as Double, second as Double):
            return first > second
        case let (first as String, second as String):
            return first > second
        default:
            return false
        }
    }

    // TODO: Make extendable to more comparable objects
    /**
     Static function for `<` operator
     */
    static func lessThan(left: Any, right: Any) -> Bool {
        switch (left, right) {
        case let (first as Int, second as Int):
            return first < second
        case let (first as Double, second as Double):
            return first < second
        case let (first as String, second as String):
            return first < second
        default:
            return false
        }
    }
}

