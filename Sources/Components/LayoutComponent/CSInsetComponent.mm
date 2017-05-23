//
//  CSInsetComponent.m
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

#import "CSInsetComponent.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"

@implementation CSInsetComponent

- (instancetype)initWithInsets:(UIEdgeInsets)insets component:(CSComponent *)child {
    return [self initWithView:nil insets:insets component:child];
}

- (instancetype)initWithView:(CSViewConfiguration *)view
                      insets:(UIEdgeInsets)insets
                   component:(CSComponent *)component {
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
