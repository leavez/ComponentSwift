//
//  CKWGestureAttribute.h
//  Pods
//
//  Created by Gao on 23/04/2017.
//
//

#import <Foundation/Foundation.h>
#import "CKWViewAttributes.h"

@interface CKWGestureAttribute: CKWViewAttribute
@property (nonatomic, readonly, nonnull) Class gestureClass;
@property (nonatomic, readonly, nonnull) SEL action;

+ (nonnull instancetype)new NS_UNAVAILABLE;
- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithSetter:(nonnull SEL)setter NS_UNAVAILABLE;
- (nonnull instancetype)initWithLayerSetter:(nonnull SEL)setter NS_UNAVAILABLE;

- (nonnull instancetype)initWithTapAction:(nonnull SEL)tapAction;
- (nonnull instancetype)initWithPanAction:(nonnull SEL)tapAction;
- (nonnull instancetype)initWithLongPressAction:(nonnull SEL)tapAction;

@end
