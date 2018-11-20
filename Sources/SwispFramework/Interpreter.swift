//
//  Interpreter.swift
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
 A simple Scheme interpreter written in Swift
 */
public struct Interpreter {

    // MARK: - Procedure Definition

    /// A Scheme Lambda is implemented as a custom Swift class
    class Lambda {

        /// Private procedure parameters
        private var parms: [Symbol]

        /// Private procedure body
        private var body: Any

        /// Private procedure environment
        private var env: Env

        /// Initializes the new procedure
        public init(_ parms: [Symbol], _ body: Any, _ env: Env) {
            self.parms = parms
            self.body = body
            self.env = env
        }

        /// Calls the given procedure
        public func call(_ args: [Any]) throws -> Any? {
            var inner = Env(parms, args, outer: env)
            return try Interpreter.eval(body, with: &inner)
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
    static func parse(_ program: String) throws -> Any {
        var tokens = tokenize(program)
        let val = try readFromTokens(&tokens)
        return val
    }

    /**
     Converts a string of characters into an array of tokens

     - Parameter string: The `String` that we are tokenizing

     - Returns: A `String` array containing the generated tokens
     */
    static func tokenize(_ string: String) -> [String] {
        var tokens: [String] = []
        var temp: String = ""

        // Define our whitespace characters
        let whitespace: [Character] = [" ", "\n", "\t", "\r"]

        // Pad the parentheses in the input string
        var padded = ""
        for char in string {
            if char == "(" {
                padded.append(" ( ")
            } else if char == ")" {
                padded.append(" ) ")
            } else {
                padded.append(char)
            }
        }
        
        // Split the now padded string by whitespace
        for char in padded {
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
            throw SwispError.SyntaxError(message: "unexpected EOF while reading")
        }

        let token = tokens.removeFirst()
        switch token {
        case "(":
            var list: [Any] = []
            
            // Iterate through tokens and recursively build atomic list
            while tokens.first != ")" {
                try list.append(readFromTokens(&tokens))
            }
            tokens.removeFirst() // pop the corresponding ")"
            
            return list
        case ")":
            throw SwispError.SyntaxError(message: "unexpected )")
        default:
            return atom(token)
        }
    }

    /**
     Numbers become numbers; every other token is left as a `String`

     - Parameter token: `String` representation of token to atomize

     - Returns: `Int` or `Double` if token is a Number, a `Symbol` (`String` alias) otherwise
     */
    static func atom(_ token: String) -> Any {
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
    static func eval(_ x: Any, with env: inout Env) throws -> Any? {
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
                throw SwispError.SyntaxError(message: "invalid constant literal")
            }
        } else if let x = x as? List {
            if x.first as? Symbol == "quote" { // quotation
                guard let lis = x[safe: 1] else {
                    throw SwispError.SyntaxError(message: "invalid quotation")
                }
                return lis
            } else if x.first as? Symbol == "if" { // conditional
                guard let test = x[safe: 1], let conseq = x[safe: 2], let alt = x[safe: 3] else {
                    throw SwispError.SyntaxError(message: "invalid conditional statement")
                }
                guard let bool = try eval(test, with: &env) as? Bool else {
                    throw SwispError.SyntaxError(message: "invalid conditional statement")
                }
                let exp = bool ? conseq : alt
                return try eval(exp, with: &env)
            } else if x.first as? Symbol == "define" { // definition
                guard let `var` = x[safe: 1] as? Symbol, let exp = x[safe: 2] else {
                    throw SwispError.SyntaxError(message: "invalid definition")
                }
                env[`var`] = try eval(exp, with: &env)
                return nil
            } else if x.first as? Symbol == "set!" { // assignment
                guard let `var` = x[safe: 1] as? Symbol, let exp = x[safe: 2], let outer = env.find(`var`) else {
                    throw SwispError.SyntaxError(message: "invalid assignment")
                }
                outer[`var`] = try eval(exp, with: &env)
                return nil
            } else if x.first as? Symbol == "lambda" { // lambda
                guard let parms = x[safe: 1] as? [Symbol], let body = x[safe: 2] as? [Any] else {
                    throw SwispError.SyntaxError(message: "invalid lambda")
                }
                return Lambda(parms, body, env)
            } else { // procedure call
                var args: [Any] = []
                guard let exp = x[safe: 0] else {
                    throw SwispError.SyntaxError(message: "invalid procedure called")
                }

                let proc = try eval(exp, with: &env)

                for element in x.dropFirst() {
                    let element = element
                    guard let arg = try eval(element, with: &env) else {
                        throw SwispError.SyntaxError(message: "invalid procedure called")
                    }
                    args.append(arg)
                }

                if let proc = proc as? Lambda {
                    return try proc.call(args)
                } else {
                    if args.count > 0 {
                        guard let proc = proc as? (([Any]) throws -> Any?) else {
                            throw SwispError.SyntaxError(message: "invalid procedure called")
                        }
                        return try proc(args)

                    } else {
                        return proc
                    }
                }
            }
        }
        throw SwispError.UnknownError
    }
    
    
    // MARK: File Interpretting Methods
    
    /**
     A method for interpretting contents of a string
     
     - Parameter contents: A `String` containing the contents to interpret
    */
    public mutating func interpret(_ contents: String) throws -> String?  {
        // Try parsing and evaluating input
        let parsed = try Interpreter.parse(contents)
        if var val = try Interpreter.eval(parsed, with: &globalEnv) {
            // If there is an output, return `String` representation
            return Interpreter.schemeString(&val)
        } else {
            // Otherwise, return nil
            return nil
        }
    }

    
    // MARK: - REPL Methods

    /**
     A prompt-read-eval-print loop

     - Parameter prompt: The prompt `String` to display in the print loop
     */
    public mutating func repl(_ prompt: String = "Swisp> ") {
        while true {
            let sharedExitMessage = "To exit REPL, type 'quit' or 'exit'."
            
            // Print prompt
            print(prompt, separator: "", terminator: "")
            
            // Check for input from stdin
            guard let input = readLine(), !input.isEmpty else {
                fputs("\(prompt)No valid input to interpret...\n", stderr)
                print("\(prompt)\(sharedExitMessage)")
                continue
            }
            
            // If input is "quit" or "exit", quit REPL
            if input == "quit" || input == "exit" {
                return
            }
            
            // Try parsing and evaluating input
            do {
                let parsed = try Interpreter.parse(input)
                if var val = try Interpreter.eval(parsed, with: &globalEnv) {
                    print(Interpreter.schemeString(&val))
                }
            } catch let error as SwispError {
                fputs("\(prompt)\(error.description)\n", stderr)
                print("\(prompt)\(sharedExitMessage)")
            } catch {
                fputs("\(prompt)\(SwispError.UnknownError.description)\n", stderr)
                print("\(prompt)\(sharedExitMessage)")
            }
        }
    }

    /**
     Convert a Swift array back into a Scheme-readable string

     - Parameter exp: Expression being evaluated and converted to a string
     */
    static func schemeString(_ exp: inout Any) -> String {
        guard let lis = exp as? [Any] else {
            return String(describing: exp)
        }

        var string = "("
        for x in lis {
            var x = x
            string.append(schemeString(&x) + " ")
        }
        if !string.isEmpty {
            string.remove(at: string.index(before: string.endIndex))
        }
        string.append(")")

        return string
    }

}
