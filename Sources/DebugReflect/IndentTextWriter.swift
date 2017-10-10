//
//  IndentTextWriter.swift
//  DebugReflect
//
//  Created by omochimetaru on 2017/10/10.
//

import Foundation

public class IndentTextWriter {
    public init() {
        lines = [""]
        indent = 0
    }
    
    public func output() -> String {
        return lines.joined(separator: "\n")
    }
    
    public func write(_ string: String) {
        let n = lines.count
        var line = lines[n-1]
        
        if line.isEmpty {
            line += String(repeating: "  ", count: indent)
        }
        
        line += string
        lines[n-1] = line
    }
    
    public func writeNewline() {
        lines.append("")
    }
    
    public func pushIndent() {
        indent += 1
    }
    
    public func popIndent() {
        indent -= 1
    }
    
    private var lines: [String]
    private var indent: Int
}
