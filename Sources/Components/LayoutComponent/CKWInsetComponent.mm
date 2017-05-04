//
//  CKWInsetComponent.m
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

#import "CKWInsetComponent.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"

@implementation CKWInsetComponent

- (instancetype)initWithInsets:(UIEdgeInsets)insets component:(CKWComponent *)child {
    return [self initWithView:nil insets:insets component:child];
}

- (instancetype)initWithView:(CKWViewConfiguration *)view
                      insets:(UIEdgeInsets)insets
                   component:(CKWComponent *)component {
    if (!component) {
        return nil;
    }
    self = [super init];
    if (self) {
        CKComponentViewConfiguration viewConfig = view ? view.convert : CKComponentViewConfiguration();
        self.realComponent = [CKInsetComponent newWithView:viewConfig insets:insets component:component.realComponent];
    }
    return self;
}

@end
