//
//  CKWGestureAttribute.h
//  Pods
//
//  Created by Gao on 23/04/2017.
//
//

#import <Foundation/Foundation.h>
#import "CKWViewAttributes.h"

/// represent CKComponentViewAttributeValue of CK
NS_SWIFT_NAME(ViewAttributeValueType)
@interface CKWViewAttributeValueType: CKWViewAttributeBase
@property (nonatomic, nonnull) CKWViewAttribute *attribute;
@property (nonatomic, nonnull) id value;
@end

NS_SWIFT_NAME(GestureAttribute)
@interface CKWGestureAttribute: CKWViewAttributeValueType
@property (nonatomic, readonly, nonnull) Class gestureClass;
@property (nonatomic, readonly, nonnull) SEL action;

+ (nonnull instancetype)new NS_UNAVAILABLE;
- (nonnull instancetype)init NS_UNAVAILABLE;

- (nonnull instancetype)initWithTapAction:(nonnull SEL)tapAction;
- (nonnull instancetype)initWithPanAction:(nonnull SEL)tapAction;
- (nonnull instancetype)initWithLongPressAction:(nonnull SEL)tapAction;

@end
