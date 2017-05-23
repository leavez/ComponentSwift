//
//  CSRatioLayoutComponent.m
//  Pods
//
//  Created by Gao on 04/05/2017.
//
//

#import "CSRatioLayoutComponent.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"
#import "macro.h"

@implementation CSRatioLayoutComponent

- (instancetype)initWithRatio:(CGFloat)ratio size:(CSSize *)size component:(CSComponent *)component {
    if (!component) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.realComponent = [CKRatioLayoutComponent newWithRatio:ratio
                                                             size:ConvertWithDefault(size, CKComponentSize())
                                                        component:component.realComponent];
    }
    return self;
}

@end
