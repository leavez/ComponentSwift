//
//  CKWCenterLayoutComponent.m
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

#import "CKWCenterLayoutComponent.h"
#import "CppHeaders.h"


/** Lays out a single child component and position it so that it is centered into the layout bounds. */
@implementation CKWCenterLayoutComponent

- (instancetype)initWithCenteringOptions:(CKWCenterLayoutComponentCenteringOptions)centeringOptions
                          sizingOptions:(CKWCenterLayoutComponentSizingOptions)sizingOptions
                                  child:(CKWComponent *)child
                                   size:(CKWSize *)size {
    if (!child) {
        return nil;
    }
    
    self = [super init];
    if (self) {
        self.realComponent =
        [CKCenterLayoutComponent
         newWithCenteringOptions:centeringOptions
         sizingOptions:sizingOptions
         child:child.realComponent
         size:size.convert];
    }
    return self;
}

@end
