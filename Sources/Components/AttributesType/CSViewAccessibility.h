//
//  CSViewAccessibility.h
//  Pods
//
//  Created by Gao on 27/05/2017.
//
//

#import "CSOptionBase.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - --------------- AccessibilityTextAttribute ---------------
// for CKComponentAccessibilityTextAttribute
NS_SWIFT_NAME(AccessibilityTextAttribute)
@interface CSAccessibilityTextAttribute : CSOptionBase
- (instancetype)initWithText:(NSString *)text NS_SWIFT_NAME(init(_:));
- (instancetype)initWithLazyTextBlock:(NSString *(^)())textBlock NS_SWIFT_NAME(init(_:));
- (BOOL)hasText;
- (nullable NSString *)value;
@end

#pragma mark - --------------- AccessibilityContext ---------------
// for CKComponentAccessibilityContext
NS_SWIFT_NAME(AccessibilityContext)
@interface CSAccessibilityContext : CSOptionBase
@property (nonatomic, nullable) NSNumber *isAccessibilityElement;
@property (nonatomic, nullable) CSAccessibilityTextAttribute *accessibilityLabel;
@property (nonatomic, nullable) SEL accessibilityComponentAction;
@end

NS_ASSUME_NONNULL_END
