# ComponentSwift

[![Version](https://img.shields.io/cocoapods/v/ComponentSwift.svg?style=flat)](http://cocoapods.org/pods/ComponentSwift)
[![License](https://img.shields.io/cocoapods/l/ComponentSwift.svg?style=flat)](http://cocoapods.org/pods/ComponentSwift)
[![Platform](https://img.shields.io/cocoapods/p/ComponentSwift.svg?style=flat)](http://cocoapods.org/pods/ComponentSwift)

ComponentSwift brings ComponentKit to Swift.

[ComponentKit](http://componentkit.org) is a react-inspired native view framework for iOS developed by Facebook. It intruduce a new abstract layer (component) to automatically handle view reuse, meanwhile provide the ability to build smooth list view easily. 

ComponentSwift is an ObjC wrapper of ComponentKit and refined for Swift. ComponentSwift is designed to be a subset of ComponentKit, implementing the most commonly used features.


## TLDR
ComponentKit is implemented and used with ObjC++, which is pretty cool, but it incompiable with swift, since swift doesn't support ObjC++.
It doesn't touch the code of ComponentKit. ...

## Supported Features
#### Components

core:
- CKComponent
- CKCompositeComponent

layout:
- CKStackLayoutComponent
- CKCenterLayoutComponent
- CKInsetComponent
- CKBackgroundLayoutComponent
- CKOverlayLayoutComponent
- CKRatioLayoutComponent
- ~~CKStaticLayoutComponentChild~~ ( not yet )

view:
- CKTextComponent
- CKImageComponent
- CKButtonComponent
- ~~CKStatefulViewComponent~~ ( not yet )
#### Datasource

- CollectionViewTransitionalDatasource
- TableViewTransitionalDatasource (unofficial)

#### Respone Chain

#### Scope and State

Scope and state are supported. Furthermore, generic has been added to them, so we got type-safety here.

The API is slightly different. `CKWComponentStateProtocol` should be adopted by component firstly. Methods about state are all provided by this protocol.

```Swift
class SwiftComponent: CompositeComponent, CKWComponentInitialStateProtocol {

    typealias StateType = Bool

    convenience init?(model:Any) {
        let scope = StateScope(with: type(of: self))
        self.init(scope: scope) { (state) -> Component? in
            state ? ComponentA() : ComponentB()
        )
    }
    
    static func initialState() -> Bool {
        return false
    }
```
#### animation


### Not Supported
- hosting view (not yet)
- ComponentController

### How to use an existed CKComponnet class 

ComponentSwift also provide classes and methods to wrap your custom CKComponet subclass conveniently. Every attributes in ComponentKit have an equivalent Objc type in ComponentSwift. 

You could subclass `CKWCompositeComponent` and use `initWithCKComponent` in its implementation. Import `CKWrapperSubclass.h` to use this stuff. Reference more from `WrapExisted` in the demo project.


## Installation

```ruby
pod "ComponentSwift"
```
## License

ComponentSwift is available under the MIT license. 
