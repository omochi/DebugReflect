public protocol DebugReflectable : CustomDebugStringConvertible {
    func debugReflect() -> DebugReflectValue
    
    static var debugTypePrinting: Bool { get }
}

extension DebugReflectable {
    public var debugDescription: String {
        let writer = DebugReflectWriter()
        writer.write(self)
        return writer.output()
    }
    public static var debugTypePrinting: Bool {
        return true
    }
}


