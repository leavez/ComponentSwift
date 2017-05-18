# ComponentSwift
[![Swift](https://img.shields.io/badge/swift-3-orange.svg?style=flat)](#)
[![License](https://img.shields.io/cocoapods/l/ComponentSwift.svg?style=flat)](http://cocoapods.org/pods/ComponentSwift)
[![Platform](https://img.shields.io/cocoapods/p/ComponentSwift.svg?style=flat)](http://cocoapods.org/pods/ComponentSwift)

ComponentSwift brings ComponentKit to swift.

[ComponentKit](http://componentkit.org) is a react-inspired native view framework for iOS developed by Facebook. It intruduce a new abstract layer (component) to automatically handle view reuse, meanwhile provide the ability to build smooth list view easily. 

ComponentSwift is an objc wrapper of ComponentKit and refined for swift. ComponentSwift is designed to be a subset of ComponentKit, implementing the most commonly used features.

### Example

```Swift
class DemoComponent: CompositeComponent {

    init?(text: String) {
        super.init(
            view:
            CKWViewConfiguration(
                attributeEnums:
                .backgroundColor(.gray),
                .tapGesture(#selector(didTapSelf))
            ),
            component:
            InnerComponent(text)
    }
// ...

```
or try real demo with `pod try ComponentSwift`

## Supported Features
#### Support:
- [x] Component:
  -  almost all build-in components. 
  -  ability to wrap an an existed CKComponent on your own
- [x] Datasource: 
  - CollectionViewTransitionalDatasource
  - TableViewTransitionalDatasource (unofficial) 
- [x] Response Chain and Actions
- [x] Scope and State
- [x] Animation


#### Not support:
- [ ] hosting view (not yet)
- [ ] component controller
- [ ] StaticLayoutComponent and StatefulViewComponent
- [ ] ...


### Work with legacy code

Legacy CKComponent classes could continue to work in swift when using ComponentSwift. Classes and methods are provided to wrap your legacy components conveniently. Every attributes in ComponentKit have an equivalent in ComponentSwift. 

Subclass `CKWCompositeComponent` and use `initWithCKComponent` in its implementation. Import `ComponentSubclass.h` to use this stuff. Reference more from `WrapExisted` in the demo project.

## TLDR
ComponentKit is implemented and used with objc++, which is pretty cool. It's incompatible with swift, since swift doesn't support objc++. So comes the ComponentSwift.

A objc wrapper is implemented to bridge componentKit to swift. It create an objc version equivalent for every type in componentKit's APIs, objc class for c++ struct/class, hiding the c++ header in the implementation. It doesn't touch deep in componentKit. The runtime code is almost the same to the one using componentKit directly in the simplest situation except for construction of objc layer, so it's safe to use.

It refined the bridged interface for swift, including notating nullability, adding default parameter and swift-only api. C++'s aggregate initialization is very expressive in componentKit. ComponentSwift try hard to simulate the api with default parameters and ExpressibleByXXXLiteral. At least we got code completion here.


## Installation

```ruby
pod "ComponentSwift"
```

The lib is released with ComponentKit v0.15.1, whose latest version drop support of cocoapods. For version 0.20, go to branch `0.20`.

## License

ComponentSwift is available under the MIT license. 




