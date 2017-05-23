//
//  CSCompositeComponent.m
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import "CSCompositeComponent.h"
#import "CSComponentInner.h"
#import "CppHeaders.h"
#import "CSCompositeComponent+DynamicClass.h"
#import "CSComponentAnimation.h"


@interface CSCompositeComponent()
@property (nonatomic) CSComponent *sub;
@end

@implementation CSCompositeComponent

- (instancetype)initWithComponent:(CSComponent *)component {
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

- (instancetype)initWithView:(CSViewConfiguration *)view component:(CSComponent *)component {

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

#pragma mark - for scope

- (instancetype)initWithScope:(CSScope *)scope component:(CSComponent *)component {
    if (!component) {
        return nil;
    }
    return [self initWithScopeInner:scope component:component componentConstructor:nil];
}


- (instancetype)initWithScope:(CSScope *)scope componentConstructor:(CSComponent *(^)(id state))component {
    if (!component) {
        return nil;
    }
    return [self initWithScopeInner:scope component:nil componentConstructor:component];
}


- (instancetype)initWithScopeInner:(CSScope *)scope
                         component:(CSComponent *)component
              componentConstructor:(CSComponent *(^)(id state))componentConstructor {

    self = [super init];
    if (self) {

        Class targetSuperClass;
        if ([self.class conformsToProtocol:@protocol(CSComponentAnimationProtocol)]) {
            targetSuperClass = CKAnimationForwarderComponnent.class;
        } else {
            targetSuperClass = CKCompositeComponent.class;
        }
        NSAssert(self.class == scope.cls, @"scope's target class should be equal to self");
        Class cls = createSubclassDynamically(self.class, targetSuperClass);

        CKComponentScope ckscope(cls, scope.identifier, scope.initialStateCreator);

        CSComponent *c = component ?: componentConstructor(ckscope.state());
        CKComponent *real = [cls newWithComponent:c.realComponent];

        if ([real isKindOfClass:[CKAnimationForwarderComponnent class]]) {
            ((CKAnimationForwarderComponnent *)real).target = (CSComponent<CSComponentAnimationProtocol> *)self;
        }

        self.realComponent = real;
        self.sub = c;
    }
    return self;
}


#pragma mark - for compatibility

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






