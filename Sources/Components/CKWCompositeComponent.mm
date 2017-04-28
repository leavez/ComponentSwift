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
        CKCompositeComponent *real = [CKCompositeComponent newWithComponent:component.realComponent];
        self.realComponent = real;
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
