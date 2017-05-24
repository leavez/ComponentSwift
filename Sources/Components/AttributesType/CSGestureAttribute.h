//
//  CSGestureAttribute.h
//  Pods
//
//  Created by Gao on 23/04/2017.
//
//

#import <Foundation/Foundation.h>
#import "CSViewAttributes.h"

/// represent CKComponentViewAttributeValue, a pair of key and value
NS_SWIFT_NAME(ViewAttributeValueType)
@interface CSViewAttributeValueType: CSViewAttributeBase
@property (nonatomic, nonnull) CSViewAttribute *attribute;
@property (nonatomic, nonnull) id value;
@end

NS_SWIFT_NAME(GestureAttribute)
@interface CSGestureAttribute: CSViewAttributeValueType
@property (nonatomic, readonly, nonnull) Class gestureClass;
@property (nonatomic, readonly, nonnull) SEL action;

+ (nonnull instancetype)new NS_UNAVAILABLE;
- (nonnull instancetype)init NS_UNAVAILABLE;

// for CKComponentTapGestureAttribute:
- (nonnull instancetype)initWithTapAction:(nonnull SEL)tapAction;
- (nonnull instancetype)initWithPanAction:(nonnull SEL)tapAction;
- (nonnull instancetype)initWithLongPressAction:(nonnull SEL)tapAction;

@end
