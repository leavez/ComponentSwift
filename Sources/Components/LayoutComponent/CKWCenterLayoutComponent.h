//
//  CKWCenterLayoutComponent.h
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

#import "CKWComponent.h"

typedef NS_OPTIONS(NSUInteger, CKWCenterLayoutComponentCenteringOptions) {
    /** The child is positioned in {0,0} relatively to the layout bounds */
    CKWCenterLayoutComponentCenteringNone = 0,
    /** The child is centered along the X axis */
    CKWCenterLayoutComponentCenteringX = 1 << 0,
    /** The child is centered along the Y axis */
    CKWCenterLayoutComponentCenteringY = 1 << 1,
    /** Convenience option to center both along the X and Y axis */
    CKWCenterLayoutComponentCenteringXY = CKWCenterLayoutComponentCenteringX | CKWCenterLayoutComponentCenteringY
};

typedef NS_OPTIONS(NSUInteger, CKWCenterLayoutComponentSizingOptions) {
    /** The component will take up the maximum size possible */
    CKWCenterLayoutComponentSizingOptionDefault,
    /** The component will take up the minimum size possible along the X axis */
    CKWCenterLayoutComponentSizingOptionMinimumX = 1 << 0,
    /** The component will take up the minimum size possible along the Y axis */
    CKWCenterLayoutComponentSizingOptionMinimumY = 1 << 1,
    /** Convenience option to take up the minimum size along both the X and Y axis */
    CKWCenterLayoutComponentSizingOptionMinimumXY = CKWCenterLayoutComponentSizingOptionMinimumX | CKWCenterLayoutComponentSizingOptionMinimumY,
};

// for CKCenterLayoutComponent.
NS_SWIFT_NAME(CenterLayoutComponent)
@interface CKWCenterLayoutComponent : CKWComponent

- (nullable instancetype)initWithCenteringOptions:(CKWCenterLayoutComponentCenteringOptions)centeringOptions
                                    sizingOptions:(CKWCenterLayoutComponentSizingOptions)sizingOptions
                                            child:(nullable CKWComponent *)child
                                             size:(nullable CKWSize *)size NS_REFINED_FOR_SWIFT;

@end
