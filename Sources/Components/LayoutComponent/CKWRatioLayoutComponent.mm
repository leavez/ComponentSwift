//
//  CKWRatioLayoutComponent.m
//  Pods
//
//  Created by Gao on 04/05/2017.
//
//

#import "CKWRatioLayoutComponent.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"
#import "macro.h"

@implementation CKWRatioLayoutComponent

- (instancetype)initWithRatio:(CGFloat)ratio size:(CKWSize *)size component:(CKWComponent *)component {
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
