//
//  CKComponnet+Injected.m
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import "CKComponent+Injected.h"
#import "CSComponentInner.h"
#import <objc/runtime.h>

@implementation CKComponent(Injected)

static NSString *key = @"com.CSrapper.component.warpper";

- (void)setWrapperStrongly:(CSComponent *)wrapper {
    objc_setAssociatedObject(self, &key, wrapper, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setWrapperWeakly:(CSComponent *)wrapper {
    objc_setAssociatedObject(self, &key, wrapper, OBJC_ASSOCIATION_ASSIGN);
}

- (CSComponent *)wrapper {
    return objc_getAssociatedObject(self, &key);
}



#pragma mark - inject responder chain

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method a = class_getInstanceMethod(self, @selector(nextResponder));
        Method b = class_getInstanceMethod(self, @selector(nextResponder_wrapperInjected));
        method_exchangeImplementations(a, b);
    });
}

- (id)nextResponder_wrapperInjected {
    if (self.wrapper) {
        return self.wrapper;
    } else {
        return [self nextResponder_wrapperInjected]; // the original
    }
}

- (id)nextResponderSkippedWrapper {
    return [self nextResponder_wrapperInjected];
}

@end
