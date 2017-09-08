//
//  DebugReflectValue.swift
//  DebugReflectable
//
//  Created by omochimetaru on 2017/09/08.
//

public enum DebugReflectValue {
    case string(String)
    case array(Array<DebugReflectable>)
    case dictionary(Array<(String, DebugReflectable)>)
    
    public static func build(_ f: (DebugReflectBuilder) throws -> Void) rethrows -> DebugReflectValue {
        let builder = DebugReflectBuilder()
        try f(builder)
        return builder.build()
    }
}
