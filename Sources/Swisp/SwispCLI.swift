//
//  SwispCLI.swift
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

import Foundation

// Output types to write to command line
internal enum CLIOutputType {
    case error
    case standard
}

/**
 Static methods for CLI management
 */
internal struct SwispCLI {
    
    /**
     Write a custom message to CLI
     */
    static func writeMessage(_ message: String, to: CLIOutputType = .standard) {
        switch to {
        case .standard:
            print("\(message)")
        case .error:
            fputs("Error: \(message)\n", stderr)
        }
    }
    
    /**
     Print usage information to CLI
     */
    static func printUsage() {
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        writeMessage("usage: \(executableName) [option] [file]")
        writeMessage("Options and arguments:")
        writeMessage("-i file:  to run Swisp with an input Scheme program (also --input)")
        writeMessage("-v:       to show version information (also --version)")
        writeMessage("-h:       to show this help information (also --help)")
        writeMessage("Type \(executableName) without any arguments to enter interactive read–eval–print loop mode.")
    }
    
    /**
     Print version information to CLI
    */
    static func printVersion() {
        let executableName = (CommandLine.arguments[0] as NSString).lastPathComponent
        writeMessage("\(executableName) \(Swisp.version)")
    }
    
}
