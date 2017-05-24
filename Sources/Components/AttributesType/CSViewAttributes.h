//
//  CSViewAttributes.h
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import <Foundation/Foundation.h>
#import "CSOptionBase.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - --------------- ViewClass ----------------------
NS_SWIFT_NAME(ViewClass)
@interface CSViewClass : CSOptionBase

typedef void (^CSViewReuseBlock)(UIView *);
typedef UIView * _Nonnull(* _Nonnull CSViewFactoryType)(void);

- (instancetype)init;
- (instancetype)initWithCls:(Class)viewClass NS_SWIFT_NAME(init(_:));
- (instancetype)initWithCls:(Class)viewClass didEnterReusePoolMessage:(nullable SEL)didEnterReusePoolMessage willLeaveReusePoolMessage:(nullable SEL)willLeaveReusePoolMessage;
- (instancetype)initWithFactory:(CSViewFactoryType)factory didEnterReusePool:(nullable CSViewReuseBlock)didEnterReusePool willLeaveReusePool:(nullable CSViewReuseBlock)willLeaveReusePool;
@end


#pragma mark - --------------- ViewAttribute ----------------------
NS_SWIFT_NAME(ViewAttributeBase)
@interface CSViewAttributeBase: CSOptionBase <NSCopying>
@end
NS_SWIFT_NAME(ViewAttribute)
@interface CSViewAttribute: CSViewAttributeBase
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithSetter:(SEL)setter NS_SWIFT_NAME(init(_:));
- (instancetype)initWithLayerSetter:(SEL)setter;
- (instancetype)initWithIdentifierString:(NSString *)string
                              applicator:(void (^ _Nonnull)(id view, id value))applicator
                            unapplicator:(void (^ _Nullable)(id view, id value))unapplicator
                                 updater:(void (^ _Nullable)(id view, id oldValue, id newValue))updater;
@end


#pragma mark - --------------- AccessibilityTextAttribute ---------------
NS_SWIFT_NAME(AccessibilityTextAttribute)
@interface CSAccessibilityTextAttribute : CSOptionBase
- (instancetype)initWithText:(NSString *)text NS_SWIFT_NAME(init(_:));
- (instancetype)initWithLazyTextBlock:(NSString *(^)())textBlock NS_SWIFT_NAME(init(_:));
- (BOOL)hasText;
- (nullable NSString *)value;
@end

#pragma mark - --------------- AccessibilityContext ---------------
NS_SWIFT_NAME(AccessibilityContext)
@interface CSAccessibilityContext : CSOptionBase
@property (nonatomic, nullable) NSNumber *isAccessibilityElement;
@property (nonatomic, nullable) CSAccessibilityTextAttribute *accessibilityLabel;
@property (nonatomic, nullable) SEL accessibilityComponentAction;
@end


#pragma mark - --------------- ViewAttributesMap ---------------
NS_SWIFT_NAME(ViewAttributeMap)
@interface CSViewAttributeMap : CSOptionBase
@property (nonatomic, readonly) NSDictionary<CSViewAttributeBase *, id> *content;
- (instancetype)initWithDictionary:(NSDictionary<CSViewAttributeBase *, id> *)dict NS_SWIFT_NAME(init(_:));
@end


#pragma mark - --------------- ViewConfiguration ---------------
NS_SWIFT_NAME(ViewConfiguration)
@interface CSViewConfiguration : CSOptionBase
@property (nonatomic, nullable) CSViewClass *cls;;
@property (nonatomic, nullable) CSViewAttributeMap *viewAttributeMap;
@property (nonatomic, nullable) CSAccessibilityContext *context;

- (instancetype)init;
- (instancetype)initWithViewClass:(nullable CSViewClass *)cls
                viewAttributeMap:(nullable CSViewAttributeMap *)viewAttributeMap;
- (instancetype)initWithViewClass:(nullable CSViewClass *)cls
                viewAttributeMap:(nullable CSViewAttributeMap *)viewAttributeMap
            accessibilityContext:(nullable CSAccessibilityContext *)context;

@end

NS_ASSUME_NONNULL_END
