//
//  SwiftTypes.swift
//  DebugReflectable
//
//  Created by omochimetaru on 2017/09/08.
//

extension Bool : DebugReflectable {
    public func debugReflect() -> DebugReflectValue {
        return .string(String(self))
    }
    public static var debugTypePrinting: Bool {
        return false
    }
}

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
        return .array(self)
    }
    public static var debugTypePrinting: Bool {
        return false
    }
}

extension Dictionary : DebugReflectable {
    public func debugReflect() -> DebugReflectValue {
        return .dictionary(map { (kv: (Any, Any)) -> (String, Any) in
            let (k, v) = kv
            return (String(describing: k), v)
        })
    }
    public static var debugTypePrinting: Bool {
        return false
    }
}
