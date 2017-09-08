//
//  DebugReflectWriter.swift
//  DebugReflectable
//
//  Created by omochimetaru on 2017/09/08.
//

import Foundation

public class DebugReflectWriter {
    public init() {
        lines = [""]
        indent = 0
    }

    public func write(_ x: DebugReflectable) {
        if type(of: x).debugTypePrinting {
            write(string: summary(of: x) + " ")
        }
        
        if let obj = castIfClass(x) {
            if visited.contains(obj) {
                write(string: "{ recursive }")
                return
            }
            visited.add(obj)
        }
        
        switch x.debugReflect() {
        case let .string(x):
            write(string: x)
        case let .array(xs):
            write(array: xs)
        case let .dictionary(xs):
            write(dictionary: xs)
        }
    }
    
    public func output() -> String {
        return lines.joined(separator: "\n")
    }
    
    private func write(string: String) {
        let n = lines.count
        var line = lines[n-1]
        
        if line.count == 0 {
            line += String.init(repeating: "  ", count: indent)
        }
        
        line += string
        lines[n-1] = line
    }
    
    private func writeNewline() {
        lines.append("")
    }
    
    private func write(array: Array<DebugReflectable>) {
        if array.count == 0 {
            write(string: "[]")
        } else {
            write(string: "[")
            writeNewline()
            
            pushIndent()
            for x in array {
                write(x)
                writeNewline()
            }
            popIndent()
            
            write(string: "]")
        }
    }
    
    private func write(dictionary: Array<(String, DebugReflectable)>) {
        if dictionary.count == 0 {
            write(string: "{}")
        } else {
            write(string: "{")
            writeNewline()
            
            pushIndent()
            for (k, v) in dictionary {
                write(string: k)
                write(string: " => ")
                write(v)
                writeNewline()
            }
            popIndent()
            
            write(string: "}")
        }
    }
    
    private func pushIndent() {
        indent += 1
    }
    private func popIndent() {
        indent -= 1
    }

    private var lines: [String]
    private var indent: Int
    
    private struct VisitedObjects {
        var objects = Array<AnyObject>()
        var addrs = Set<Int>()
        
        func contains(_ x: AnyObject) -> Bool {
            return addrs.contains(addr(of: x))
        }
        
        mutating func add(_ x: AnyObject) {
            objects.append(x)
            addrs.insert(addr(of: x))
        }
    }
    
    private var visited = VisitedObjects()

}
