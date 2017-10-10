//
//  AnyDebugReflectable.swift
//  DebugReflectable
//
//  Created by omochimetaru on 2017/09/08.
//

public struct AnyDebugReflectable : DebugReflectable {
    public init<X: DebugReflectable>(_ base: X) {
        self.base = base
    }
    
    public func debugReflect() -> DebugReflectValue {
        return base.debugReflect()
    }
    
    private var base: DebugReflectable
}
