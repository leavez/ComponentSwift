//
//  CKWComponentAnimationProtocol.m
//  Pods
//
//  Created by Gao on 14/05/2017.
//
//

#import "CKWComponentAnimation.h"
#import "CppHeaders.h"

/// _CKComponentAnimation have no default initializer, which cannot used as property in Objc class.
/// so we write a wrapper.
struct _CKComponentAnimation {
    _CKComponentAnimation(): inner(CKComponentAnimation(nil, nil)) {};
    _CKComponentAnimation(CKComponentAnimation real):inner(real){}
    CKComponentAnimation inner;
};

@implementation CKWComponentAnimation {
    _CKComponentAnimation _inner;
}

- (instancetype)initWithComponent:(CKWComponent *)component animation:(CAAnimation *)animation layerPath:(NSString *)layerPath {
    self = [super init];
    if (self) {
        _inner = _CKComponentAnimation(CKComponentAnimation(component.realComponentWithoutChangingOwnership,
                                                            animation));
    }
    return self;
}

- (instancetype)initWithWillRemount:(id (^)())willRemount didRemount:(id (^)(id))didRemount cleanup:(void (^)(id))cleanup {
    self = [super init];
    if (self) {
        _inner = _CKComponentAnimation(CKComponentAnimation({
            .willRemount = willRemount,
            .didRemount = didRemount,
            .cleanup = cleanup
        }));
    }
    return self;
}
- (CKComponentAnimation)convert {
    return _inner.inner;
}

@end
