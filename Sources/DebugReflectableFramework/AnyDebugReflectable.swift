//
//  AnyDebugReflectable.swift
//  DebugReflectable
//
//  Created by omochimetaru on 2017/09/08.
//

public struct AnyDebugReflectable : DebugReflectable {
    public init(_ debugReflect: @escaping () -> DebugReflectValue) {
        self._debugReflect = debugReflect
    }
    
    public func debugReflect() -> DebugReflectValue {
        return _debugReflect()
    }
    
    private var _debugReflect: () -> DebugReflectValue
}
