//
//  Util.swift
//  DebugReflectable
//
//  Created by omochimetaru on 2017/09/08.
//

import Foundation

internal func addr(of x: AnyObject) -> Int {
    return Int(bitPattern: Unmanaged.passUnretained(x).toOpaque())
}

internal func summary(of x: Any) -> String {
    let typeStr = String(describing: type(of: x))
    let addrStr: String
    if let obj = castIfClass(x) {
        addrStr = String(format: "@0x%x", addr(of: obj))
    } else {
        addrStr = ""
    }
    return "\(typeStr)\(addrStr)"
}

internal func castIfClass(_ x: Any) -> AnyObject? {
    guard type(of: x) is AnyObject.Type else {
        return nil
    }
    return x as AnyObject
}

internal func convertToDebugReflectable(_ x: Any) -> DebugReflectable {
    if let refl = x as? DebugReflectable {
        return refl
    }
    return AnyDebugReflectable {
        .string(String(describing: x))
    }
}
