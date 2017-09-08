public protocol DebugReflectable : CustomDebugStringConvertible {
    func debugReflect() -> DebugReflectValue
    
    func debugDump() -> String
    
    static var debugTypePrinting: Bool { get }
}

extension DebugReflectable {
    public var debugDescription: String {
        return debugDump()
    }
    
    public func debugDump() -> String {
        let writer = DebugReflectWriter()
        writer.write(self)
        return writer.output()
    }
    
    public static var debugTypePrinting: Bool {
        return true
    }
}


