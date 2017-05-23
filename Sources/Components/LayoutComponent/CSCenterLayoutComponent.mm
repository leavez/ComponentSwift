//
//  CSCenterLayoutComponent.m
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

#import "CSCenterLayoutComponent.h"
#import "CppHeaders.h"


/** Lays out a single child component and position it so that it is centered into the layout bounds. */
@implementation CSCenterLayoutComponent

- (instancetype)initWithCenteringOptions:(CSCenterLayoutComponentCenteringOptions)centeringOptions
                          sizingOptions:(CSCenterLayoutComponentSizingOptions)sizingOptions
                                  child:(CSComponent *)child
                                   size:(CSSize *)size {
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
