//
//  DebugReflectBuilder.swift
//  DebugReflectable
//
//  Created by omochimetaru on 2017/09/08.
//

import Foundation

public class DebugReflectBuilder {
    public init() {
    }
    
    public var fields: Array<(String, DebugReflectable)> = []
    
    public func field(_ name: String, _ field: DebugReflectable) {
        fields.append((name, field))
    }
    
    public func fieldIfPresent<X: DebugReflectable>(_ name: String, _ field: X?) {
        if let field = field {
            self.field(name, field)
        }
    }
    
    public func build() -> DebugReflectValue {
        return .dictionary(fields)
    }
}
