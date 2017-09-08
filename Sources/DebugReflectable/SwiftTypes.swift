//
//  SwiftTypes.swift
//  DebugReflectable
//
//  Created by omochimetaru on 2017/09/08.
//

extension Int : DebugReflectable {
    public func debugReflect() -> DebugReflectValue {
        return .string(String(self))
    }
    public static var debugTypePrinting: Bool {
        return false
    }
}

extension UInt : DebugReflectable {
    public func debugReflect() -> DebugReflectValue {
        return .string(String(self))
    }
    public static var debugTypePrinting: Bool {
        return false
    }
}

extension Float : DebugReflectable {
    public func debugReflect() -> DebugReflectValue {
        return .string(String(self))
    }
    public static var debugTypePrinting: Bool {
        return false
    }
}

extension Double : DebugReflectable {
    public func debugReflect() -> DebugReflectValue {
        return .string(String(self))
    }
    public static var debugTypePrinting: Bool {
        return false
    }
}

extension String : DebugReflectable {
    public func debugReflect() -> DebugReflectValue {
        return .string(self)
    }
    public static var debugTypePrinting: Bool {
        return false
    }
}

extension Array : DebugReflectable {
    public func debugReflect() -> DebugReflectValue {
        return .array(map (convertToDebugReflectable))
    }
    public static var debugTypePrinting: Bool {
        return false
    }
}

extension Dictionary : DebugReflectable {
    public func debugReflect() -> DebugReflectValue {
        return .dictionary(map { (kv: (Any, Any)) -> (String, DebugReflectable) in
            let (k, v) = kv
            return (String(describing: k), convertToDebugReflectable(v))
        })
    }
    public static var debugTypePrinting: Bool {
        return false
    }
}
