//
//  CSInsetComponent.h
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

#import "CSComponent.h"

/**
 for CKInsetComponent.
 */
NS_SWIFT_NAME(InsetComponent)
@interface CSInsetComponent : CSComponent

- (nullable instancetype)initWithInsets:(UIEdgeInsets)insets component:(nullable CSComponent *)child;

/**
 @param view Passed to CKComponent +newWithView:size:. The view, if any, will extend outside the insets.
 @param insets The amount of space to inset on each side.
 @param component The wrapped child component to inset. If nil, this method returns nil.
 */
- (nullable instancetype)initWithView:(nullable CSViewConfiguration *)view
                               insets:(UIEdgeInsets)insets
                            component:(nullable CSComponent *)component;

@end
