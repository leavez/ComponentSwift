//
//  CSComponent.m
//  Pods
//
//  Created by Gao on 20/04/2017.
//
//

#import "CSComponent.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"
#import "CKComponent+Injected.h"

@implementation CSComponent {
    CKComponent *_realComponentStrong;
    __weak CKComponent *_realComponentWeak;
}


- (instancetype)initWithView:(CSViewConfiguration *)view
                        size:(CSSize *)size
{
    self = [super init];
    if (self) {
        CKComponentViewConfiguration viewConfig = view ? view.convert : CKComponentViewConfiguration();
        self.realComponent = [CKComponent newWithView:viewConfig size:size.convert];
    }
    return self;
}

#pragma mark - inner ck component

- (void)setRealComponent:(CKComponent *)realComponent {
    _realComponentStrong = realComponent;
    [realComponent setWrapperWeakly:self];
}

- (CKComponent *)realComponent {
    if (_realComponentStrong) {
        CKComponent *real = _realComponentStrong;
        _realComponentStrong = nil;

        [real setWrapperStrongly:self];
        _realComponentWeak = real;
        
        return real;
    }
    return _realComponentWeak;
}


- (CKComponent *)realComponentWithoutChangingOwnership {
    return _realComponentStrong ?: _realComponentWeak;
}

#pragma mark - injected reponder chain

- (id)nextResponder {
    // ckcomponent's to return it's wrapper
    return [self.realComponent nextResponderSkippedWrapper];
}

- (id)targetForAction:(SEL)action withSender:(id)sender {
    return [self canPerformAction:action withSender:sender] ? self : [[self nextResponder] targetForAction:action withSender:sender];
}

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender {
    return [self respondsToSelector:action];
}

@end
