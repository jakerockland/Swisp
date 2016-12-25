//
//  Interpreter.swift
//  Sources
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
 Extension to Array for safer indexing
 */
private extension Array {
    subscript (safe index: Int) -> Element? {
        return (index >= 0 && index < count) ? self[index] : nil
    }
}

/// A Scheme Symbol is implemented as a Swift `String`
public typealias Symbol = String

/// A Scheme List is implemented as a Swift `[Any]` array
public typealias List = [Any]

/// A Scheme Number is implemented as a custom Swift enum that wraps `Int` and `Double`
public enum Number {
    case Int
    case Double
}

/// A Scheme Env is implemented as a custom Swift class that wraps `Dictionary`
public class Env {
    
    /// Private dictionary representing environment's contents
    private var elements: [Symbol: Any]
    
    /// Private outer environment, if any
    private var outer: Env?
    
    /// Initializes a new environment with given dictionary
    public init(_ elements: [Symbol: Any] = [:], outer: Env? = nil) {
        self.elements = elements
        self.outer = outer
    }
    
    /// Initializes a new environment with given parameters and arguments
    public init(_ parms: [Symbol], _ args: [Any], outer: Env? = nil) {
        self.elements = [:]
        self.outer = outer
    }
    
    /// Gets value corresponding to given key, if any
    public subscript(_ key: Symbol) -> Any? {
        get {
            return elements[key]
        }
        set {
            elements[key] = newValue
        }
    }
    
    /// Find the innermost Env where `element` appears
    public func find(_ key: Symbol) -> Env? {
        return (elements[key] != nil) ? self : outer?.find(key)
    }
    
}

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
    ] as [Symbol: Any])

/**
 A simple Scheme interpreter written in Swift
 */
public struct Interpreter {
    
    // MARK: - Error Definitions
    
    /// Custom type for errors encountered while interpreting
    enum InterpreterError: String, Error {
        case cannotParseTokens = "unable to parse tokens"
        case unexpectedEOF = "unexpected EOF while reading"
        case unexpectedParenthesis = "unexpected )"
        case invalidConstantLiteral = "invalid constant literal"
        case invalidConditionalStatement = "invalid conditional statement"
        case invalidQuotation = "invalid quotation"
        case invalidDefinition = "invalid definition"
        case invalidAssignment = "invalid assignment"
        case invalidProcedureCalled = "invalid procedure called"
        case invalidProcedureInput = "invalid procedure input"
        case unknown = "should never occur"
    }
    
    
    // MARK: - Procedure Definition
    
    
    /// A Scheme Procedure is implemented as a custom Swift class that TODO
    class Procedure {
        
        /// Private procedure parameters
        private var parms: [Symbol]
        
        /// Private procedure body
        private var body: Any
        
        /// Private procedure environment
        private var env: Env
        
        /// Initializes the new procedure
        public init(parms: [Symbol], body: Any, env: Env) {
            self.parms = parms
            self.body = body
            self.env = env
        }
        
        /// Calls the given procedure
        public func call(args: [Any]) throws -> Any? {
            var inner = Env(parms, args, outer: env)
            return try Interpreter.eval(&body, with: &inner)
        }
        
    }
    
    
    // MARK: - Interpreter Properties
    
    /// The standard global environment for the interpreter
    var globalEnv: Env
    
    
    // MARK: - Initializer
    
    /**
     Public initializer for `Intepreter`
     
     - Parameter env: initial environment for interpreter, defaults to the standard environment
     */
    public init(env: Env = standardEnv) {
        globalEnv = env
    }
    
    // MARK: - Parser Methods
    
    /**
     Numbers become numbers; every other token is a symbol
     
     - Parameter program: The text content of the program to be parsed
     
     - Returns: The abstract syntax tree of the associated program
     */
    static func parse(_ program: String) throws -> [Any] {
        var tokens = tokenize(program)
        guard let parsed = try readFromTokens(&tokens) as? [Any] else {
            throw InterpreterError.cannotParseTokens
        }
        return parsed
    }
    
    /**
     Converts a string of characters into an array of tokens
     
     - Parameter string: The `String` that we are tokenizing
     
     - Returns: A `String` array containing the generated tokens
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
     Read an expression from a sequence of tokens
     
     - Parameter tokens: The `String` array containing a sequence of tokens
     
     - Returns: A nested array representation of the corresponding abstract syntax tree
     */
    static func readFromTokens(_ tokens: inout [String]) throws -> Any {
        guard tokens.count > 0 else {
            throw InterpreterError.unexpectedEOF
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
            throw InterpreterError.unexpectedParenthesis
        default:
            return atom(token)
        }
    }
    
    /**
     Numbers become numbers; every other token is left as a `String`
     
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
    
    
    // MARK: - Evaluation Methods
    
    /**
     Evaluate an expression in a given environment
     
     - Parameter x: The statement to be evaluated
     
     - Parameter env: The environment with which to evaluate the expression (default is the global environment)
     
     - Returns: The evaluated statement
     */
    static func eval(_ x: inout Any, with env: inout Env) throws -> Any? {
        if let x = x as? Symbol { // variable reference
            guard let ref = env.find(x)?[x] else {
                return x
            }
            return ref as Any
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
                throw InterpreterError.invalidConstantLiteral
            }
        } else if let x = x as? List {
            if x.first as? Symbol == "quote" || x.first as? Symbol == "'" { // quotation
                guard var exp = x[safe: 1] else {
                    throw InterpreterError.invalidQuotation
                }
                return schemeString(&exp)
            } else if x.first as? Symbol == "if" { // conditional
                guard var test = x[safe: 1], let conseq = x[safe: 2], let alt = x[safe: 3] else {
                    throw InterpreterError.invalidConditionalStatement
                }
                guard let bool = try eval(&test, with: &env) as? Bool else {
                    throw InterpreterError.invalidConditionalStatement
                }
                var exp = bool ? conseq : alt
                return try eval(&exp, with: &env)
            } else if x.first as? Symbol == "define" { // definition
                guard let `var` = x[safe: 1] as? Symbol, var exp = x[safe: 2] else {
                    throw InterpreterError.invalidDefinition
                }
                env[`var`] = try eval(&exp, with: &env)
                return nil
            } else if x.first as? Symbol == "set!" { // assignment
                // TODO: Add tests for this
                guard let `var` = x[safe: 1] as? Symbol, var exp = x[safe: 2] else {
                    throw InterpreterError.invalidAssignment
                }
                env.find(`var`)?[`var`] = try eval(&exp, with: &env)
                return nil
            } else { // procedure call
                var args: [Any] = []
                guard var exp = x[safe: 0] else {
                    throw InterpreterError.invalidProcedureCalled
                }
                
                let proc = try eval(&exp, with: &env)
                
                for element in x.dropFirst() {
                    var element = element
                    guard let arg = try eval(&element, with: &env) else {
                        throw InterpreterError.invalidProcedureCalled
                    }
                    args.append(arg)
                }
                
                switch args.count {
                case 0:
                    return proc
                case 1:
                    guard let proc = proc as? (Any)->Any? else {
                        throw InterpreterError.invalidProcedureCalled
                    }
                    guard let result = proc(args[safe: 0] as Any) else {
                        throw InterpreterError.invalidProcedureInput
                    }
                    return result
                case 2:
                    guard let proc = proc as? (Any, Any)->Any? else {
                        throw InterpreterError.invalidProcedureCalled
                    }
                    guard let result = proc(args[safe: 0] as Any, args[safe: 1] as Any) else {
                        throw InterpreterError.invalidProcedureInput
                    }
                    return result
                default:
                    guard let proc = proc as? ([Any])->Any? else {
                        throw InterpreterError.invalidProcedureCalled
                    }
                    guard let result = proc(args) else {
                        throw InterpreterError.invalidProcedureInput
                    }
                    return result
                }
            }
        }
        throw InterpreterError.unknown
    }
    
    
    // MARK: - REPL Methods
    
    /**
     A prompt-read-eval-print loop
     
     - Parameter prompt: The prompt string to display in the print loop
     */
    public mutating func repl(_ prompt: String = "Swisp> ") {
        while true {
            print(prompt, separator: "", terminator: "")
            
            guard let input = readLine() else {
                print("\(prompt)No valid input to interpret...")
                continue
            }
            
            do {
                var parsed = try Interpreter.parse(input) as Any
                if var val = try Interpreter.eval(&parsed, with: &globalEnv) {
                    print(Interpreter.schemeString(&val))
                }
            } catch let error as InterpreterError {
                print("\(prompt)Interpreter error: \(error.rawValue)!")
            } catch {
                print("\(prompt)Unknown error occured!")
            }
        }
    }
    
    /**
     Convert a Swift array back into a Scheme-readable string
     
     - Parameter exp: Expression being evaluated and converted to a string
     */
    static func schemeString(_ exp: inout Any) -> String {
        guard let lis = exp as? List else {
            return String(describing: exp)
        }
        
        var string = "("
        for x in lis {
            var x = x
            string += schemeString(&x) + " "
        }
        if !string.isEmpty {
            string.remove(at: string.index(before: string.endIndex))
        }
        string += ")"
        
        return string
    }
    
}
