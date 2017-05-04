//
//  CKWBackgroundComponent.m
//  Pods
//
//  Created by Gao on 04/05/2017.
//
//

#import "CKWBackgroundComponent.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"

@implementation CKWBackgroundComponent

- (nullable instancetype)initWithComponent:(nullable CKWComponent *)component
                                background:(nullable CKWComponent *)background
{
    if (!component) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.realComponent = [CKBackgroundLayoutComponent newWithComponent:component.realComponent
                                                                background:background.realComponent];
    }
    return self;
}
@end


@implementation CKWOverlayLayoutComponent

- (nullable instancetype)initWithComponent:(nullable CKWComponent *)component
                                   overlay:(nullable CKWComponent *)overlay
{
    if (!component) {
        return nil;
    }
    self = [super init];
    if (self) {
        self.realComponent = [CKOverlayLayoutComponent newWithComponent:component.realComponent
                                                                overlay:overlay.realComponent];
    }
    return self;
}
@end
