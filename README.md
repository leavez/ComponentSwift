# ComponentSwift

[![CI Status](http://img.shields.io/travis/gaojiji@gmail.com/CKWrapper.svg?style=flat)](https://travis-ci.org/gaojiji@gmail.com/CKWrapper)
[![Version](https://img.shields.io/cocoapods/v/CKWrapper.svg?style=flat)](http://cocoapods.org/pods/CKWrapper)
[![License](https://img.shields.io/cocoapods/l/CKWrapper.svg?style=flat)](http://cocoapods.org/pods/CKWrapper)
[![Platform](https://img.shields.io/cocoapods/p/CKWrapper.svg?style=flat)](http://cocoapods.org/pods/CKWrapper)

**ComponentSwift is now working in progress.**

ComponentSwift is an Objective-C wrapper of ComponentKit for Swift. 

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





### Not Supported
- ComponentController
- animation

### How to use an existed CKComponnet class 

ComponentSwift also provide classes and methods to wrap your custom CKComponet subclass conveniently. Every attributes in ComponentKit have an equivalent Objc type in ComponentSwift. 

You could subclass `CKWCompositeComponent` and use `initWithCKComponent` in its implementation. Import `CKWrapperSubclass.h` to use this stuff. Reference more from `WrapExisted` in the demo project.


## Installation

```ruby
pod "ComponentSwift"
```
## License

ComponentSwift is available under the MIT license. 
