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
    
    public var fields: Array<(String, Any)> = []
    
    public func field(_ name: String, _ field: Any) {
        fields.append((name, field))
    }
    
    public func fieldIfPresent(_ name: String, _ field: Any?) {
        if let field = field {
            self.field(name, field)
        }
    }
    
    public func build() -> DebugReflectValue {
        return .dictionary(fields)
    }
}
