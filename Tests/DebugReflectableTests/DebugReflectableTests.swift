import XCTest
@testable import DebugReflect

import Foundation

class Cat : DebugReflectable {
    init(name: String) {
        self.name = name
    }
    
    var name: String
    var children: [Cat] = []
    var props: [String: String] = [:]
    var bestFriend: Cat?
    var stone: Stone?

    func debugReflect() -> DebugReflectValue {
        return .build { b in
            b.field("name", name)
            b.field("children", children)
            b.field("props", props)
            b.fieldIfPresent("bestFriend", bestFriend)
            b.fieldIfPresent("stone", stone)
        }
    }
}

struct Stone : DebugReflectable {
    func debugReflect() -> DebugReflectValue {
        return .build { b in
        }
    }
}

class DebugReflectableTests: XCTestCase {
    func testExample() {
        let cat0 = Cat(name: "apple")
        let cat1 = Cat(name: "banana")
        let cat2 = Cat(name: "cherry")
        cat2.bestFriend = cat1
        cat0.children = [
            cat1,
            cat2,
            cat0
        ]
        cat0.props = [
            "blood": "A"
        ]
        cat0.stone = Stone()
        
        let pattern = """
Cat@0x(\\w+) \\{
  name => apple
  children => \\[
    Cat@0x(\\w+) \\{
      name => banana
      children => \\[\\]
      props => \\{\\}
    \\}
    Cat@0x(\\w+) \\{
      name => cherry
      children => \\[\\]
      props => \\{\\}
      bestFriend => Cat@0x(\\w+) \\{ recursive \\}
    \\}
    Cat@0x(\\w+) \\{ recursive \\}
  \\]
  props => \\{
    blood => A
  \\}
  stone => Stone \\{\\}
\\}
"""
        let regex = try! NSRegularExpression(pattern: pattern, options: [])
        
        let text = cat0.debugDescription as NSString
        
        let matchOpt = regex.firstMatch(in: text as String, options: [],
                                     range: NSRange(location: 0, length: text.length))
        XCTAssertNotNil(matchOpt, "match pattern")
        let match = matchOpt!
        let strs = (1...5).map { text.substring(with: match.range(at: $0)) }

        XCTAssertNotEqual(strs[0], strs[1])
        XCTAssertNotEqual(strs[0], strs[2])
        XCTAssertNotEqual(strs[1], strs[2])
        XCTAssertEqual(strs[0], strs[4])
        XCTAssertEqual(strs[1], strs[3])
    }
}
