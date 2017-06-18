//
//  CSCenterLayoutComponent.h
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

#import "CSComponent.h"

typedef NS_OPTIONS(NSUInteger, CSCenterLayoutComponentCenteringOptions) {
    /** The child is positioned in {0,0} relatively to the layout bounds */
    CSCenterLayoutComponentCenteringNone = 0,
    /** The child is centered along the X axis */
    CSCenterLayoutComponentCenteringX = 1 << 0,
    /** The child is centered along the Y axis */
    CSCenterLayoutComponentCenteringY = 1 << 1,
    /** Convenience option to center both along the X and Y axis */
    CSCenterLayoutComponentCenteringXY = CSCenterLayoutComponentCenteringX | CSCenterLayoutComponentCenteringY
} NS_SWIFT_NAME(CenterLayoutComponentCenteringOptions);


typedef NS_OPTIONS(NSUInteger, CSCenterLayoutComponentSizingOptions) {
    /** The component will take up the maximum size possible */
    CSCenterLayoutComponentSizingOptionDefault,
    /** The component will take up the minimum size possible along the X axis */
    CSCenterLayoutComponentSizingOptionMinimumX = 1 << 0,
    /** The component will take up the minimum size possible along the Y axis */
    CSCenterLayoutComponentSizingOptionMinimumY = 1 << 1,
    /** Convenience option to take up the minimum size along both the X and Y axis */
    CSCenterLayoutComponentSizingOptionMinimumXY = CSCenterLayoutComponentSizingOptionMinimumX | CSCenterLayoutComponentSizingOptionMinimumY,
} NS_SWIFT_NAME(CenterLayoutComponentSizingOptions);

// for CKCenterLayoutComponent.
NS_SWIFT_NAME(__CenterLayoutComponent)
@interface CSCenterLayoutComponent : CSComponent

- (nullable instancetype)initWithCenteringOptions:(CSCenterLayoutComponentCenteringOptions)centeringOptions
                                    sizingOptions:(CSCenterLayoutComponentSizingOptions)sizingOptions
                                            child:(nullable CSComponent *)child
                                             size:(nullable CSSize *)size NS_REFINED_FOR_SWIFT;

@end
