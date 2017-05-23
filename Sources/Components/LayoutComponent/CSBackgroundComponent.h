//
//  CSBackgroundComponent.h
//  Pods
//
//  Created by Gao on 04/05/2017.
//
//

#import "CSComponent.h"

/// for CKBackgroundLayoutComponent
NS_SWIFT_NAME(BackgroundComponent)
@interface CSBackgroundComponent : CSComponent

- (nullable instancetype)initWithComponent:(nullable CSComponent *)component
                               background:(nullable CSComponent *)background;

- (nonnull instancetype)initWithView:(nullable CSViewConfiguration *)view
                                size:(nullable CSSize *)size NS_UNAVAILABLE;

@end

/// for CKOverlayLayoutComponent
NS_SWIFT_NAME(OverlayLayoutComponent)
@interface CSOverlayLayoutComponent : CSComponent

- (nullable instancetype)initWithComponent:(nullable CSComponent *)component
                                   overlay:(nullable CSComponent *)overlay;

- (nonnull instancetype)initWithView:(nullable CSViewConfiguration *)view
                                size:(nullable CSSize *)size NS_UNAVAILABLE;

@end


