//
//  CKWCompositeComponent.m
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import "CKWCompositeComponent.h"
#import "CKWComponentInner.h"
#import "CppHeaders.h"
#import <objc/runtime.h>

Class getCorrespondingCKClass(Class cls, Class superClass) {

    NSCAssert(cls != nil, @"class shouldn't be nil");
    NSString *prefix = @"CKWDynamicSubclass_";
    NSString *subclassName = [prefix stringByAppendingString:NSStringFromClass(cls)];
    Class subclass = NSClassFromString(subclassName);

    if (!subclass) {
        subclass = objc_allocateClassPair(superClass, [subclassName UTF8String], 0);
        objc_registerClassPair(subclass);
    }
    return subclass;
}



@interface CKWCompositeComponent()
@property (nonatomic) CKWComponent *sub;
@end

@implementation CKWCompositeComponent

- (instancetype)initWithComponent:(CKWComponent *)component {
    if (!component) {
        return nil;
    }

    self = [super init];
    if (self) {
        self.sub = component;
        self.realComponent = [CKCompositeComponent newWithComponent:component.realComponent];;
    }
    return self;
}

- (instancetype)initWithScope:(CKWScope *)scope component:(CKWComponent *)component {
    if (!component) {
        return nil;
    }

    self = [super init];
    if (self) {
        Class cls = getCorrespondingCKClass(scope.cls, CKCompositeComponent.class);
        CKComponentScope ckscope(cls, scope.identifier, scope.initialStateCreator);
        self.realComponent = [cls newWithComponent:component.realComponent];
        self.sub = component;
    }
    return self;
}


- (instancetype)initWithScope:(CKWScope *)scope componentConstructor:(CKWComponent *(^)(id state))component {
    if (!component) {
        return nil;
    }

    self = [super init];
    if (self) {
        Class cls = getCorrespondingCKClass(scope.cls, CKCompositeComponent.class);
        CKComponentScope ckscope(cls, scope.identifier, scope.initialStateCreator);

        CKWComponent *c = component(ckscope.state());
        self.realComponent = [cls newWithComponent:c.realComponent];
        self.sub = c;
    }
    return self;
}

- (instancetype)initWithView:(CKWViewConfiguration *)view component:(CKWComponent *)component {

    if (!component) {
        return nil;
    }

    self = [super init];
    if (self) {
        self.sub = component;
        CKComponentViewConfiguration viewConfig = view != nil ? view.convert : CKComponentViewConfiguration();
        CKCompositeComponent *real = [CKCompositeComponent newWithView:viewConfig component:component.realComponent];
        self.realComponent = real;
    }
    return self;
}


- (instancetype)initWithCKComponent:(CKComponent *)component {
    if (!component) {
        return nil;
    }

    self = [super init];
    if (self) {
        self.realComponent = component;
    }
    return self;
}

@end






