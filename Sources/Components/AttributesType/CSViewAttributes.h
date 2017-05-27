//
//  CSViewAttributes.h
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import <Foundation/Foundation.h>
#import "CSOptionBase.h"
#import "CSViewAccessibility.h"

NS_ASSUME_NONNULL_BEGIN

#pragma mark - --------------- ViewClass ----------------------
// for CKComponentViewClass
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

// for CKComponentViewAttribute
NS_SWIFT_NAME(ViewAttribute)
@interface CSViewAttribute: CSOptionBase
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithSetter:(SEL)setter NS_SWIFT_NAME(init(_:));
- (instancetype)initWithLayerSetter:(SEL)setter;
- (instancetype)initWithIdentifierString:(NSString *)string
                              applicator:(void (^ _Nonnull)(id view, id value))applicator
                            unapplicator:(void (^ _Nullable)(id view, id value))unapplicator
                                 updater:(void (^ _Nullable)(id view, id oldValue, id newValue))updater NS_REFINED_FOR_SWIFT;
@end

// for CKComponentViewAttributeValue, a pair of key and value
NS_SWIFT_NAME(ViewAttributeValue)
@interface CSViewAttributeValue: CSOptionBase
@property (nonatomic, nonnull) CSViewAttribute *key;
@property (nonatomic, nullable) id value;
@end



#pragma mark - --------------- ViewAttributesMap ---------------
// fof CKViewComponentAttributeValueMap
NS_SWIFT_NAME(ViewAttributeMap)
@interface CSViewAttributeMap : CSOptionBase
@property (nonatomic, readonly) NSArray<CSViewAttributeValue *> *content;
/// Due to the limit of objc, this api is different from componentKit.
/// The key may be `CSViewAttribute` or `CSViewAttributeValueType`. If `CSViewAttributeValueType`, value in
/// for this key is meaningless, won't be used.
- (instancetype)initWithItems:(NSArray<CSViewAttributeValue *> *)items NS_SWIFT_NAME(init(_:));
@end


#pragma mark - --------------- ViewConfiguration ---------------
// for CKComponentViewConfiguration
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
