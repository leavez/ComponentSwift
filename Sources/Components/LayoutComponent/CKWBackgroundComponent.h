//
//  CKWBackgroundComponent.h
//  Pods
//
//  Created by Gao on 04/05/2017.
//
//

#import "CKWComponent.h"

/// for CKBackgroundLayoutComponent
NS_SWIFT_NAME(BackgroundComponent)
@interface CKWBackgroundComponent : CKWComponent

- (nullable instancetype)initWithComponent:(nullable CKWComponent *)component
                               background:(nullable CKWComponent *)background;

- (nonnull instancetype)initWithView:(nullable CKWViewConfiguration *)view
                                size:(nullable CKWSize *)size NS_UNAVAILABLE;

@end

/// for CKOverlayLayoutComponent
NS_SWIFT_NAME(OverlayLayoutComponent)
@interface CKWOverlayLayoutComponent : CKWComponent

- (nullable instancetype)initWithComponent:(nullable CKWComponent *)component
                                   overlay:(nullable CKWComponent *)overlay;

- (nonnull instancetype)initWithView:(nullable CKWViewConfiguration *)view
                                size:(nullable CKWSize *)size NS_UNAVAILABLE;

@end


