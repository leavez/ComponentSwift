//
//  CSRatioLayoutComponent.h
//  Pods
//
//  Created by Gao on 04/05/2017.
//
//

#import "CSComponent.h"

/// for CKRatioLayoutComponent.
NS_SWIFT_NAME(RatioLayoutComponent)
@interface CSRatioLayoutComponent : CSComponent

- (nonnull instancetype)initWithRatio:(CGFloat)h_w_ratio
                                 size:(nullable CSSize *)size
                            component:(nonnull CSComponent *)component NS_REFINED_FOR_SWIFT;

- (nonnull instancetype)initWithView:(nullable CSViewConfiguration *)view
                                size:(nullable CSSize *)size NS_UNAVAILABLE;
@end
