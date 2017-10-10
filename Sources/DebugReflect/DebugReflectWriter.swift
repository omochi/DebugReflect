//
//  DebugReflectWriter.swift
//  DebugReflectable
//
//  Created by omochimetaru on 2017/09/08.
//

import Foundation

public class DebugReflectWriter {
    public init() {}
    
    public func write(_ x: DebugReflectable) {
        if let obj = castIfClass(x) {
            if visited.contains(obj) {
                if isPrintingSummary(x) {
                    writer.write(debugSummary(of: x) + " ")
                }
                writer.write(" { recursive }")
                return
            }
            visited.add(obj)
        }
        
        switch x.debugReflect() {
        case let .string(t):
            if isPrintingSummary(x) {
                writer.write(debugSummary(of: x) + "(")
            }
            writer.write(t)
            if isPrintingSummary(x) {
                writer.write(")")
            }
        case let .array(xs):
            if isPrintingSummary(x) {
                writer.write(debugSummary(of: x) + " ")
            }
            write(array: xs)
        case let .dictionary(xs):
            if isPrintingSummary(x) {
                writer.write(debugSummary(of: x) + " ")
            }
            write(dictionary: xs)
        }
    }
    
    public func output() -> String {
        return writer.output()
    }
    
    private func isPrintingSummary(_ x: DebugReflectable) -> Bool {
        return type(of: x).debugTypePrinting
    }
    
    private func write(any: Any) {
        guard let dr = any as? DebugReflectable else {
            writer.write(String(describing: any))
            return
        }
        write(dr)
    }
    
    private func write(array: Array<Any>) {
        if array.count == 0 {
            writer.write("[]")
        } else {
            writer.write("[")
            writer.writeNewline()
            
            writer.pushIndent()
            for x in array {
                write(any: x)
                writer.writeNewline()
            }
            writer.popIndent()
            
            writer.write("]")
        }
    }
    
    private func write(dictionary: Array<(String, Any)>) {
        if dictionary.count == 0 {
            writer.write("{}")
        } else {
            writer.write("{")
            writer.writeNewline()
            
            writer.pushIndent()
            for (k, v) in dictionary {
                writer.write(k)
                writer.write(" => ")
                write(any: v)
                writer.writeNewline()
            }
            writer.popIndent()
            
            writer.write("}")
        }
    }

    private struct VisitedObjects {
        var objects = Array<AnyObject>()
        var addrs = Set<Int>()
        
        func contains(_ x: AnyObject) -> Bool {
            return addrs.contains(address(of: x))
        }
        
        mutating func add(_ x: AnyObject) {
            objects.append(x)
            addrs.insert(address(of: x))
        }
    }
    
    private var visited = VisitedObjects()
    
    private var writer = IndentTextWriter()

}
