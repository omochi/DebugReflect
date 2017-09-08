# DebugReflectable

This library help dump your data structure in Swift.
It supports classes and reference cycle.

# Example

Type implementation.

```swift
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
```

Using.

```swift
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
        print(cat0.debugDescription)
```

Output.

```text
Cat@0x8750e850 {
  name => apple
  children => [
    Cat@0x8750f010 {
      name => banana
      children => []
      props => {}
    }
    Cat@0x8750fb20 {
      name => cherry
      children => []
      props => {}
      bestFriend => Cat@0x8750f010 { recursive }
    }
    Cat@0x8750e850 { recursive }
  ]
  props => {
    blood => A
  }
  stone => Stone {}
}
```


