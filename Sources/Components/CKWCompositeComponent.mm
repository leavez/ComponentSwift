//
//  CKWCompositeComponent.m
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import "CKWCompositeComponent.h"
#import "CKWComponentInner.h"

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

@end
