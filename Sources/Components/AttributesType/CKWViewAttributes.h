//
//  CKWViewAttributes.h
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import <Foundation/Foundation.h>
#import "CKWCreatorBase.h"

#pragma mark - --------------- ViewClass ----------------------
@interface CKWViewClass : CKWCreatorBase

@property (nonatomic) Class viewClass;
@property (nonatomic) SEL didEnterReusePoolMessage;
@property (nonatomic) SEL willLeaveReusePoolMessage;

typedef void (^CKWViewReuseBlock)(UIView *);
typedef UIView *(*CKWViewFactoryType)(void);

@property (nonatomic, assign) CKWViewFactoryType factory;
@property (nonatomic) CKWViewReuseBlock didEnterReusePool;
@property (nonatomic) CKWViewReuseBlock willLeaveReusePool;


- (instancetype)init;
- (instancetype)initWithCls:(Class)viewClass;
- (instancetype)initWithCls:(Class)viewClass didEnterReusePoolMessage:(SEL)didEnterReusePoolMessage willLeaveReusePoolMessage:(SEL)willLeaveReusePoolMessage;
- (instancetype)initWithFactory:(CKWViewFactoryType)factory didEnterReusePool:(CKWViewReuseBlock)didEnterReusePool willLeaveReusePool:(CKWViewReuseBlock)willLeaveReusePool;
@end


#pragma mark - --------------- ViewAttribute ----------------------
@interface CKWViewAttribute : CKWCreatorBase
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)initWithSetter:(SEL)setter;
- (instancetype)initWithLayerSetter:(SEL)setter;
@end

#pragma mark - --------------- AccessibilityContext ---------------
@interface CKWAccessibilityContext : CKWCreatorBase
@property (nonatomic) NSNumber *isAccessibilityElement;
//@property (nonatomic) CKComponentAccessibilityTextAttribute accessibilityLabel;
@property (nonatomic) SEL accessibilityComponentAction;
@end


#pragma mark - --------------- ViewConfiguration ---------------
@interface CKWViewConfiguration : CKWCreatorBase
@property (nonatomic) CKWViewClass *cls;
@property (nonatomic) NSDictionary<CKWViewAttribute *, id> *viewAttributeMap;
@property (nonatomic) CKWAccessibilityContext *context;

- (instancetype)init;
- (instancetype)initWithViewClass:(CKWViewClass *)cls
                viewAttributeMap:(NSDictionary<CKWViewAttribute *, id> *)viewAttributeMap;
- (instancetype)initWithViewClass:(CKWViewClass *)cls
                viewAttributeMap:(NSDictionary<CKWViewAttribute *, id> *)viewAttributeMap
            accessibilityContext:(CKWAccessibilityContext *)context;

@end

