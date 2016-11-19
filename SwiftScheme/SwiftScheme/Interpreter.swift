//
//  Interpreter.swift
//  SwiftScheme
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
 Converts a string of characters into an array of tokens.
 
 - Parameter string: The `String` that we are tokenizing.
 
 - Returns: A `String` array containing the generated tokens.
 */
func tokenize(_ string: String) -> [String] {
    return string.replacingOccurrences(of: "(", with: " ( ").replacingOccurrences(of: ")", with: " ) ").components(separatedBy: " ")
}

