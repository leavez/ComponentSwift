//
//  CKWViewAttributes.h
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import <Foundation/Foundation.h>
#import "CKWCreatorBase.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - --------------- ViewClass ----------------------
@interface CKWViewClass : CKWCreatorBase

typedef void (^CKWViewReuseBlock)(UIView *);
typedef UIView * _Nonnull(* _Nonnull CKWViewFactoryType)(void);

- (instancetype)init;
- (instancetype)initWithCls:(Class)viewClass NS_SWIFT_NAME(init(_:));
- (instancetype)initWithCls:(Class)viewClass didEnterReusePoolMessage:(nullable SEL)didEnterReusePoolMessage willLeaveReusePoolMessage:(nullable SEL)willLeaveReusePoolMessage;
- (instancetype)initWithFactory:(CKWViewFactoryType)factory didEnterReusePool:(nullable CKWViewReuseBlock)didEnterReusePool willLeaveReusePool:(nullable CKWViewReuseBlock)willLeaveReusePool;
@end


#pragma mark - --------------- ViewAttribute ----------------------
@interface CKWViewAttributeBase: CKWCreatorBase
@end
@interface CKWViewAttribute: CKWViewAttributeBase
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithSetter:(SEL)setter NS_SWIFT_NAME(init(_:));
- (instancetype)initWithLayerSetter:(SEL)setter;
- (instancetype)initWithIdentifierString:(NSString *)string
                              applicator:(void (^ _Nonnull)(id view, id value))applicator
                            unapplicator:(void (^ _Nullable)(id view, id value))unapplicator
                                 updater:(void (^ _Nullable)(id view, id oldValue, id newValue))updater;
@end


#pragma mark - --------------- AccessibilityTextAttribute ---------------
@interface CKWAccessibilityTextAttribute : CKWCreatorBase
- (instancetype)initWithText:(NSString *)text NS_SWIFT_NAME(init(_:));
- (instancetype)initWithLazyTextBlock:(NSString *(^)())textBlock NS_SWIFT_NAME(init(_:));
- (BOOL)hasText;
- (nullable NSString *)value;
@end

#pragma mark - --------------- AccessibilityContext ---------------
@interface CKWAccessibilityContext : CKWCreatorBase
@property (nonatomic, nullable) NSNumber *isAccessibilityElement;
@property (nonatomic, nullable) CKWAccessibilityTextAttribute *accessibilityLabel;
@property (nonatomic, nullable) SEL accessibilityComponentAction;
@end


#pragma mark - --------------- ViewConfiguration ---------------
typedef NSDictionary<CKWViewAttributeBase *, id> CKWViewAttributeMap;
@interface CKWViewConfiguration : CKWCreatorBase
@property (nonatomic, nullable) CKWViewClass *cls;;
@property (nonatomic, nullable) CKWViewAttributeMap *viewAttributeMap;
@property (nonatomic, nullable) CKWAccessibilityContext *context;

- (instancetype)init;
- (instancetype)initWithViewClass:(nullable CKWViewClass *)cls
                viewAttributeMap:(nullable CKWViewAttributeMap *)viewAttributeMap;
- (instancetype)initWithViewClass:(nullable CKWViewClass *)cls
                viewAttributeMap:(nullable CKWViewAttributeMap *)viewAttributeMap
            accessibilityContext:(nullable CKWAccessibilityContext *)context;

@end

NS_ASSUME_NONNULL_END
