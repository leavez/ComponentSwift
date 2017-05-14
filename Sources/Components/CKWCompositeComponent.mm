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
#import "CKWCompositeComponent+DynamicClass.h"
#import "CKWComponentAnimation.h"


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

#pragma mark - for scope

- (instancetype)initWithScope:(CKWScope *)scope component:(CKWComponent *)component {
    if (!component) {
        return nil;
    }
    return [self initWithScopeInner:scope component:component componentConstructor:nil];
}


- (instancetype)initWithScope:(CKWScope *)scope componentConstructor:(CKWComponent *(^)(id state))component {
    if (!component) {
        return nil;
    }
    return [self initWithScopeInner:scope component:nil componentConstructor:component];
}


- (instancetype)initWithScopeInner:(CKWScope *)scope
                         component:(CKWComponent *)component
              componentConstructor:(CKWComponent *(^)(id state))componentConstructor {

    self = [super init];
    if (self) {

        Class targetSuperClass;
        if ([self.class conformsToProtocol:@protocol(CKWComponentAnimationProtocol)]) {
            targetSuperClass = CKAnimationForwarderComponnent.class;
        } else {
            targetSuperClass = CKCompositeComponent.class;
        }
        NSAssert(self.class == scope.cls, @"scope's target class should be equal to self");
        Class cls = createSubclassDynamically(self.class, targetSuperClass);

        CKComponentScope ckscope(cls, scope.identifier, scope.initialStateCreator);

        CKWComponent *c = component ?: componentConstructor(ckscope.state());
        CKComponent *real = [cls newWithComponent:c.realComponent];

        if ([real isKindOfClass:[CKAnimationForwarderComponnent class]]) {
            ((CKAnimationForwarderComponnent *)real).target = (CKWComponent<CKWComponentAnimationProtocol> *)self;
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






