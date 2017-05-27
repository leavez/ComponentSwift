//
//  CSGestureAttribute.h
//  Pods
//
//  Created by Gao on 23/04/2017.
//
//

#import <Foundation/Foundation.h>
#import "CSViewAttributes.h"

NS_SWIFT_NAME(GestureAttributeValue)
@interface CSGestureAttributeValue: CSViewAttributeValue
@property (nonatomic, readonly, nonnull) Class gestureClass;
@property (nonatomic, readonly, nonnull) SEL action;

+ (nonnull instancetype)new NS_UNAVAILABLE;
- (nonnull instancetype)init NS_UNAVAILABLE;

// for CKComponentTapGestureAttribute:
- (nonnull instancetype)initWithTapAction:(nonnull SEL)tapAction;
- (nonnull instancetype)initWithPanAction:(nonnull SEL)tapAction;
- (nonnull instancetype)initWithLongPressAction:(nonnull SEL)tapAction;

@end
