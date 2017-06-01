
## Life Cycle of CSComponent

The simplest way to build an wrapper is that the wrapper is only a way of constructing the real component and don’t touch any thing of the inner system.  Components passed to componentKit is still CKComponent class. And the wrapper object, just let it go.

ComponentSwift just want to work in this way. However, there’s a problems: the response chain!  The wrapper object(CSComponent) should be existed to play a role in responder chain, if we want to write action method in our old way.

So when a CSComponent (the wrapper) is created, a corresponding CKComponent will be created simultaneously and hold by the wrapper. When component is passed to the datasource or composited by other component, the wrapper will be simply retained by CKComponent.

## Responder chain

CSComponent will be inserted just after CKComponent in the original responder chain, before componentController. 

It modified the `nextResponder` of CKComponent using runtime. It’s the only modification to componentKit.

## Actions

Just like the old way.

```Swift
init?(model: Any) {
    super.init(component:
        Component(
            view:
            ViewConfiguration(
                attributes:
                .tapGesture(#selector(didTap))
            ),
            size: .size(100, 100))
    )
}

func didTap(sender: Any) { 
    print("tapped")
}
```

## Scope and State

Scope and state are supported. Furthermore, generic has been added to them, so we got type-safety here.

The API is slightly different. `ComponentStateProtocol` should be adopted by component firstly. Methods about state are all provided by this protocol.

```Swift
class SwiftComponent: CompositeComponent, ComponentInitialStateProtocol {

    typealias StateType = Bool

    init?(model:Any) {
        let scope = StateScope(with: type(of: self))
        super.init(scope: scope) { (state) -> Component? in
            state ? ComponentA() : ComponentB()
        }
    }

    static func initialState() -> Bool {
        return false
    }
}
```

## Animation

Just like state, animation need conform to `ComponentAnimationProtocol`. It requires 2 methods

```Swift
func animationsOnInitialMount() -> [ComponentAnimation]? {
    return nil
}

func animations(fromPreviousComponent previousComponent: Component?) -> [ComponentAnimation]? {
    guard let textComponent = textComponent else {
        return nil
    }

    let fade = CABasicAnimation(keyPath: "opacity")
    fade.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionDefault)
    fade.duration = 1
    fade.fromValue = 0
    fade.toValue = 1

    return [ ComponentAnimation(component: textComponent, animation: fade) ]
}
```

## Work with Legacy Code
Wrap CKComponent like this, then it's available to swift.

```objc
#import <ComponentSwift/ComponentSwift.h>

@interface AnimatedNetworkImageComponent : CSCompositeComponent
- (nonnull instancetype)initWithURL:(nullable NSURL *)url
                   imageDownloader:(nullable id)imageDownloader
                              size:(nullable CSSize *)size
                        attributes:(nullable CSViewAttributeMap *)attributes
                         endurance:(NSTimeInterval)endurance
                transitionDuration:(NSTimeInterval)transitionDuration;
@end
```
```objc
// AnimatedNetworkImageComponent.mm
#import <ComponentSwift/ComponentSubclass.h>
#import "CKFadeNetworkImageComponent.h"

@implementation AnimatedNetworkImageComponent

-(instancetype)initWithURL:(NSURL *)url imageDownloader:(id<CKNetworkImageDownloading>)imageDownloader size:(CSSize *)size attributes:(CSViewAttributeMap *)attributes endurance:(NSTimeInterval)endurance transitionDuration:(NSTimeInterval)transitionDuration
{
    CKComponent *component = [CKAnimatedNetworkImageComponent
                              newWithURL:url
                              imageDownloader:imageDownloader
                              size:ConvertWithDefault(size, CKComponentSize())
                              attributes:ConvertWithDefault(attributes, CKViewComponentAttributeValueMap())
                              endurance:endurance
                              transitionDuration:transitionDuration];
    return [super initWithCKComponent:component];
}
@end
```