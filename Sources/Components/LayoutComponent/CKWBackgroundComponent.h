//
//  CKWBackgroundComponent.h
//  Pods
//
//  Created by Gao on 04/05/2017.
//
//

#import "CKWComponent.h"

/// for CKBackgroundLayoutComponent
@interface CKWBackgroundComponent : CKWComponent

- (nullable instancetype)initWithComponent:(nullable CKWComponent *)component
                               background:(nullable CKWComponent *)background;

@end

/// for CKOverlayLayoutComponent
@interface CKWOverlayLayoutComponent : CKWComponent

- (nullable instancetype)initWithComponent:(nullable CKWComponent *)component
                                   overlay:(nullable CKWComponent *)overlay;

@end


