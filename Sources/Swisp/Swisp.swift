//
//  Swisp.swift
//  Swisp
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

import SwispFramework
import Foundation

/**
 Custom type for input options
 */
internal enum OptionType: String {
    case version = "v"
    case help = "h"
    case input = "i"
    case unknown
    
    /**
     Initialize option type based on input string
     */
    init(value: String) {
        switch value {
        case "v", "version": self = .version
        case "h", "help": self = .help
        case "i", "input": self = .input
        default: self = .unknown
        }
    }
}

/**
 Main Swisp command-line program static methods
 */
internal class Swisp {
    
    // Version property for Swisp app
    static let version = "0.1.0"
    
    /**
     Run Swisp in interactive REPL mode
    */
    static func replMode() {
        // Create interpreter instantiation
        var interpreter = Interpreter()
        
        // Launch read-eval-print loop
        interpreter.repl()
    }
    
    /**
     Run Swisp error mode
    */
    
    /**
     Run Swisp in static mode
    */
    static func staticMode() {
        // Get input from command line stdin
        let _ = CommandLine.argc
        let arg = CommandLine.arguments[1]

        // Check input for capturing arguments with one dash
        var argVal = String(arg[arg.index(after: arg.startIndex)...])
        var regOption = OptionType(value: argVal)
        if regOption == .unknown {
            // Check input for capturing arguments with two dashes
            argVal = String(arg[arg.index(after: arg.index(after: arg.startIndex))...])
            regOption = OptionType(value: argVal)
        }
        
        // Handle Parsed results
        switch regOption {
        case .help:
            // Print usage information
            SwispCLI.printUsage()
        case .version:
            // Print version information
            SwispCLI.printVersion()
        case .input, .unknown:
            // Print usage information in all other cases
            SwispCLI.printUsage()
        }
    }
    
    /**
     Run Swisp in file input mode
     */
    static func fileMode() {
        // Get input from command line stdin
        let _ = CommandLine.argc
        let arg = CommandLine.arguments[1]
        let file = CommandLine.arguments[2]
        
        // Check input for capturing arguments with one dash
        var argVal = String(arg[arg.index(after: arg.startIndex)...])
        var regOption = OptionType(value: argVal)
        if regOption != .input {
            // Check input for capturing arguments with two dashes
            argVal = String(arg[arg.index(after: arg.index(after: arg.startIndex))...])
            regOption = OptionType(value: argVal)
            guard regOption == .input else {
                // Print malformed file mode input, print usage and exit
                SwispCLI.printUsage()
                return
            }
        }
        
        // Get file path from file name + curreent path
        if let path = URL(string: FileManager.default.currentDirectoryPath)?.appendingPathComponent(file),
            let contents = try? String(contentsOfFile: path.absoluteString) {
            // Create interpreter instantiation
            var interpreter = Interpreter()
            
            // Interate through file contents line-by-line
            for line in contents.components(separatedBy: .newlines) {
                // Skip lines that are only whitespace or empty
                guard !line.isEmpty && !line.isWhitespace() else {
                    continue
                }
                
                // Parse and interpret line
                do {
                    // If input was interpretted correctly output result to console
                    if let result = try interpreter.interpret(line) {
                        SwispCLI.writeMessage(result)
                    }
                } catch let error as SwispError {
                    SwispCLI.writeMessage(error.description, to: .error)
                } catch {
                    SwispCLI.writeMessage(SwispError.UnknownError.description, to: .error)
                }
            }
        } else {
            // Write error message if invalid input file
            SwispCLI.writeMessage("No input file found with name '\(file)'!", to: .error)
        }
    }
    
    /**
     Run Swisp error mode
     */
    static func errorMode() {
        // Print usage information
        SwispCLI.printUsage()
    }
    
}
