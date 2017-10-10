//
//  DebugReflectValue.swift
//  DebugReflectable
//
//  Created by omochimetaru on 2017/09/08.
//

public enum DebugReflectValue {
    case string(String)
    case array(Array<Any>)
    case dictionary(Array<(String, Any)>)
    
    public static func build(_ f: (DebugReflectBuilder) -> Void) -> DebugReflectValue {
        let builder = DebugReflectBuilder()
        f(builder)
        return builder.build()
    }
}
