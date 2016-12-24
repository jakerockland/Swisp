//
//  Interpreter.swift
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

/// A Scheme Symbol is implemented as a Swift `String`.
public typealias Symbol = String

/// A Scheme List is implemented as a Swift `[Any]` array.
public typealias List = [Any]

/// A Scheme Number is implemented as a Swift `NSNumber`.
public typealias Number = NSNumber

/// A Scheme Env is implemented as a Swift `[String: Any]` dictionary.
public typealias Env = [Symbol: Any]

/**
 A simple Scheme interpreter written in Swift
 */
public struct Interpreter {

    // MARK: - Error Definitions

    /**
     Custom type for errors encountered while interpreting
     */
    enum InterpreterError: Error {
        /// Case representing a syntax error that arises
        case SyntaxError(_: String)
    }


    // MARK: - Interpreter Properties

    /// The standard global environment for the interpreter
    var globalEnv: Env = Interpreter.standardEnv()


    // MARK: - Parser Methods

    /**
     Numbers become numbers; every other token is a symbol.

     - Parameter program: The text content of the program to be parsed.

     - Returns: The abstract syntax tree of the associated program.
     */
    static func parse(_ program: String) throws -> [Any] {
        var tokens = tokenize(program)
        guard let parsed = try readFromTokens(&tokens) as? [Any] else {
            throw InterpreterError.SyntaxError("unable to parse tokens")
        }
        return parsed
    }

    /**
     Converts a string of characters into an array of tokens.

     - Parameter string: The `String` that we are tokenizing.

     - Returns: A `String` array containing the generated tokens.
     */
    static func tokenize(_ string: String) -> [String] {
        var tokens: [String] = []
        var temp: String = ""

        let whitespace: [Character] = [" ", "\n", "\t", "\r"]
        let padded = string.replacingOccurrences(of: "(", with: " ( ").replacingOccurrences(of: ")", with: " ) ")

        for char in padded.characters {
            if whitespace.contains(char) {
                if temp != "" {
                    tokens.append(temp)
                    temp = ""
                }
            } else {
                temp.append(char)
            }
        }

        return tokens
    }

    /**
     Read an expression from a sequence of tokens.

     - Parameter tokens: The `String` array containing a sequence of tokens.

     - Returns: A nested array representation of the corresponding abstract syntax tree.
     */
    static func readFromTokens(_ tokens: inout [String]) throws -> Any {
        guard tokens.count > 0 else {
            throw InterpreterError.SyntaxError("unexpected EOF while reading")
        }

        let token = tokens.removeFirst()
        switch token {
        case "(":
            var list: [Any] = []
            while tokens.first != ")" {
                try list.append(readFromTokens(&tokens))
            }
            tokens.removeFirst() // pop the corresponding ")"
            return list
        case ")":
            throw InterpreterError.SyntaxError("unexpected )")
        default:
            return atom(token)
        }
    }

    /**
     Numbers become numbers; every other token is left as a `String`.

     - Parameter token: `String` representation of token to atomize

     - Returns: `Int` or `Double` if token is a Number, a `Symbol` (`String` alias) otherwise
     */
    static func atom(_ token: String) -> AnyHashable {
        if let int = Int(token) {
            return int
        } else if let float = Double(token) {
            return float
        } else {
            return token as Symbol
        }

    }


    // MARK: - Environment Methods

    /**
     Generates the Scheme standard environment.

     - Returns: An environment with some Scheme standard procedures.
     */
    static func standardEnv() -> Env {
        let env = [
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
            //            // "factorial": factorial, // TODO
            "floor":    Math.floor,
            //            "fmod":     fmod,
            //            "frexp":    frexp,
            //            // "fsum": fsum, // TODO
            //            "isinf":    isinf,
            //            "isnan":    isnan,
            //            "ldexp":    ldexp,
            //            "trunc":    trunc,
            //            // Power and logarithmic functions
            //            "exp":      exp,
            //            "log":      log,
            //            "log1p":    log1p,
            //            "log10":    log10,
            //            "pow":      pow,
            //            "sqrt":     sqrt,
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
            //            // "degrees": degrees, // TODO
            //            // "radians": radians, // TODO
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
            // Misc.
            "abs":      Library.abs,
            //            "append":   { $0 + $1 },
            //            // "apply": apply, // [TODO](https://www.drivenbycode.com/the-missing-apply-function-in-swift/)
            //            "begin":    { $0[-1] },
            //            "car":      { $0[0] },
            //            "cdr":      { $0.dropFirst() },
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
            ] as Env

        return env
    }


    // MARK: - Evaluation Methods

    /**
     Evaluate an expression in an environment.

     - Parameter x: The statement to be evaluated.

     - Parameter env: The environment with which to evaluate the expression (default is the global environment)

     - Returns: The evaluated statement.
     */
    static func eval(_ x: inout Any, withEnvironment env: inout Env) throws -> Any {
        if let x = x as? Symbol { // variable reference
            guard env[x] != nil else {
                return x
            }

            return env[x] as Any
        } else if !(x is List) { // constant literal
            switch x {
            case let x as Int:
                return x
            case let x as Double:
                return x
            case let x as Bool:
                return x
            case let x as Symbol:
                return x
            default:
                throw InterpreterError.SyntaxError("trying to evaluate invalid statement")
            }
        } else if let x = x as? List, x.first as? Symbol == "if" { // conditional
            var test = x[1]
            let conseq = x[2]
            let alt = x[3]

            guard let bool = try eval(&test, withEnvironment: &env) as? Bool else {
                throw InterpreterError.SyntaxError("invalid conditional statement")
            }

            var exp = bool ? conseq : alt
            return try eval(&exp, withEnvironment: &env)
        } else if let x = x as? List, x.first as? Symbol == "define" { // definition
            guard let `var` = x[1] as? Symbol else {
                throw InterpreterError.SyntaxError("invalid variable definition")
            }
            var exp = x[2]

            env[`var`] = try eval(&exp, withEnvironment: &env)
            return 0
        } else if let x = x as? List { // procedure call
            var args: [Any] = []
            var exp = x[0]

            let proc = try eval(&exp, withEnvironment: &env)

            for arg in x.dropFirst() {
                var arg = arg
                args.append(try eval(&arg, withEnvironment: &env))
            }

            switch args.count {
            case 0:
                return proc
            case 1:
                guard let proc = proc as? (Any)->Any? else {
                    throw InterpreterError.SyntaxError("unknown single parameter function")
                }
                guard let result = proc(args.first as Any) else {
                    throw InterpreterError.SyntaxError("bad input to single parameter function")
                }
                return result
            case 2:
                guard let proc = proc as? (Any, Any)->Any? else {
                    throw InterpreterError.SyntaxError("unknown two parameter function")
                }
                guard let result = proc(args[0], args[1]) else {
                    throw InterpreterError.SyntaxError("bad input to two parameter function")
                }
                return result
            default:
                guard let proc = proc as? (Any...)->Any? else {
                    throw InterpreterError.SyntaxError("unknown variadic parameter function")
                }
                guard let result = proc(args) else {
                    throw InterpreterError.SyntaxError("bad input to variadic parameter function")
                }
                return result
            }
        }
        throw InterpreterError.SyntaxError("should never occur")
    }


    // MARK: - REPL Methods

    /**
     A prompt-read-eval-print loop.

     - Parameter prompt: The prompt string to display in the print loop.
     */
    mutating func repl(_ prompt: String = "Swisp> ") {
        while true {
            print(prompt, separator: "", terminator: "")

            guard let input = readLine() else {
                print("\(prompt)No valid input to interpret...")
                continue
            }

            do {
                var parsed = try Interpreter.parse(input) as Any
                let val = try Interpreter.eval(&parsed, withEnvironment: &self.globalEnv)
                print(Interpreter.schemeString(val))
            } catch InterpreterError.SyntaxError(let message) {
                print("\(prompt)Interpreter error: \(message)!")
            } catch {
                print("\(prompt)Unknown error occured!")
            }
        }
    }

    /**
     Convert a Swift array back into a Scheme-readable string.

     - Parameter exp: Expression being evaluated and converted to a string.
     */
    static func schemeString(_ exp: Any) -> String {
        guard let lis = exp as? List else {
            return String(describing: exp)
        }
        
        return "( \(lis.map(schemeString)) )"
    }
    
}
