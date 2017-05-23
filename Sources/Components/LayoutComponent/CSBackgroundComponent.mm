//
//  CSBackgroundComponent.m
//  Pods
//
//  Created by Gao on 04/05/2017.
//
//

#import "CSBackgroundComponent.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"

@implementation CSBackgroundComponent

- (nullable instancetype)initWithComponent:(nullable CSComponent *)component
                                background:(nullable CSComponent *)background
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


@implementation CSOverlayLayoutComponent

- (nullable instancetype)initWithComponent:(nullable CSComponent *)component
                                   overlay:(nullable CSComponent *)overlay
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
