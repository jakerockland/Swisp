//
//  Math.swift
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
 - 'log10'
 - 'exp'
 - 'sqrt'
 - 'acos'
 - 'asin'
 - 'atan'
 - 'atan2'
 - 'cos'
 - 'hypot'
 - 'sin'
 - 'tan'
 - 'degrees'
 - 'radians'
 - 'acosh'
 - 'asinh'
 - 'atanh'
 - 'cosh'
 - 'sinh'
 - 'tanh'
 */
internal struct Math {
    
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
            return Foundation.scalbn(val, exp)
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
        case let (val as Int):
            return Foundation.exp(Double(val))
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
        case let (val as Int):
            return Foundation.log(Double(val))
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
        case let (val as Int):
            return Foundation.log1p(Double(val))
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
        case let (val as Int):
            return Foundation.log10(Double(val))
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
        case let (x as Int, y as Int):
            return Int(Foundation.pow(Double(x), Double(y)))
        case let (x as Int, y as Double):
            return Foundation.pow(Double(x), y)
        case let (x as Double, y as Int):
            return Foundation.pow(x, Double(y))
        case let (x as Double, y as Double):
            return Foundation.pow(x, y)
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
        case let (val as Int):
            return Int(Foundation.sqrt(Double(val)))
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `acos` operation
     */
    static func acos(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.acos(val)
        case let (val as Int):
            return Foundation.acos(Double(val))
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `asin` operation
     */
    static func asin(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.asin(val)
        case let (val as Int):
            return Foundation.asin(Double(val))
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `atan` operation
     */
    static func atan(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.atan(val)
        case let (val as Int):
            return Foundation.atan(Double(val))
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `atan2` operation
     */
    static func atan2(_ args: [Any]) throws -> Any? {
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0], args[safe: 1]) {
        case let (val1 as Int, val2 as Int):
            return Foundation.atan2(Double(val1), Double(val2))
        case let (val1 as Int, val2 as Double):
            return Foundation.atan2(Double(val1), val2)
        case let (val1 as Double, val2 as Int):
            return Foundation.atan2(val1, Double(val2))
        case let (val1 as Double, val2 as Double):
            return Foundation.atan2(val1, val2)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `cos` operation
     */
    static func cos(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.cos(val)
        case let (val as Int):
            return Foundation.cos(Double(val))
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `hypot` operation
     */
    static func hypot(_ args: [Any]) throws -> Any? {
        guard args.count == 2 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0], args[safe: 1]) {
        case let (val1 as Int, val2 as Int):
            return Foundation.hypot(Double(val1), Double(val2))
        case let (val1 as Int, val2 as Double):
            return Foundation.hypot(Double(val1), val2)
        case let (val1 as Double, val2 as Int):
            return Foundation.hypot(val1, Double(val2))
        case let (val1 as Double, val2 as Double):
            return Foundation.hypot(val1, val2)
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `sin` operation
     */
    static func sin(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.sin(val)
        case let (val as Int):
            return Foundation.sin(Double(val))
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `tan` operation
     */
    static func tan(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.tan(val)
        case let (val as Int):
            return Foundation.tan(Double(val))
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `acosh` operation
     */
    static func acosh(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.acosh(val)
        case let (val as Int):
            return Foundation.acosh(Double(val))
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `degrees` operation
     */
    static func degrees(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return val * 180 / Double.pi
        case let (val as Int):
            return Double(val) * 180 / Double.pi
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }

    /**
     Static function for `radians` operation
     */
    static func radians(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return val * Double.pi / 180
        case let (val as Int):
            return Double(val) * Double.pi / 180
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `asinh` operation
     */
    static func asinh(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.asinh(val)
        case let (val as Int):
            return Foundation.asinh(Double(val))
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `atanh` operation
     */
    static func atanh(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.atanh(val)
        case let (val as Int):
            return Foundation.atanh(Double(val))
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `cosh` operation
     */
    static func cosh(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.cosh(val)
        case let (val as Int):
            return Foundation.cosh(Double(val))
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `sinh` operation
     */
    static func sinh(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.sinh(val)
        case let (val as Int):
            return Foundation.sinh(Double(val))
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
    /**
     Static function for `tanh` operation
     */
    static func tanh(_ args: [Any]) throws -> Any? {
        guard args.count == 1 else {
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
        switch (args[safe: 0]) {
        case let (val as Double):
            return Foundation.tanh(val)
        case let (val as Int):
            return Foundation.tanh(Double(val))
        default:
            throw SwispError.SyntaxError(message: "invalid procedure input")
        }
    }
    
}
