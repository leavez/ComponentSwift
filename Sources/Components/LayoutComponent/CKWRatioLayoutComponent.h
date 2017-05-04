//
//  CKWRatioLayoutComponent.h
//  Pods
//
//  Created by Gao on 04/05/2017.
//
//

#import "CKWComponent.h"

/// for CKRatioLayoutComponent.
NS_SWIFT_NAME(RatioLayoutComponent)
@interface CKWRatioLayoutComponent : CKWComponent

- (nonnull instancetype)initWithRatio:(CGFloat)h_w_ratio
                                 size:(nullable CKWSize *)size
                            component:(nonnull CKWComponent *)component;

- (nonnull instancetype)initWithView:(nullable CKWViewConfiguration *)view
                                size:(nullable CKWSize *)size NS_UNAVAILABLE;
@end
