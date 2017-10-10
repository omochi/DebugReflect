//
//  Util.swift
//  DebugReflectable
//
//  Created by omochimetaru on 2017/09/08.
//

import Foundation

public func address(of x: AnyObject) -> Int {
    return Int(bitPattern: Unmanaged.passUnretained(x).toOpaque())
}

public func debugSummary(of x: Any) -> String {
    let typeStr = String(describing: type(of: x))
    let addrStr: String
    if let obj = castIfClass(x) {
        addrStr = String(format: "@0x%x", address(of: obj))
    } else {
        addrStr = ""
    }
    return "\(typeStr)\(addrStr)"
}

public func castIfClass(_ x: Any) -> AnyObject? {
    guard type(of: x) is AnyObject.Type else {
        return nil
    }
    return x as AnyObject
}

