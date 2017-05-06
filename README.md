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

#### datasource

#### Respone Chain


### Not Supported
- ComponentController
- animation

## How to use an existed CKComponnet class 

ComponentSwift also provide classes and methods to wrap your custom CKComponet subclass conveniently. Every attributes in ComponentKit have an equivalent Objc type in ComponentSwift. 

You could subclass `CKWCompositeComponent` and use `initWithCKComponent` in its implementation. Import `CKWrapperSubclass.h` to use this stuff. Reference more from `WrapExisted` in the demo project.


## Installation

```ruby
pod "ComponentSwift"
```
## License

CKWrapper is available under the MIT license. 