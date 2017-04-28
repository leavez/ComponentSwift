//
//  CKWViewAttributes.m
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import "CKWViewAttributes.h"
#import "CKWViewAttribute+Inner.h"
#import "CKWGestureAttribute.h"
#import <ComponentKit/ComponentKit.h>
#import "macro.h"

@implementation CKWViewClass {
    CKComponentViewClass _inner;
}

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithCls:(Class)viewClass {
    return [self initWithCls:viewClass didEnterReusePoolMessage:nil willLeaveReusePoolMessage:nil];
}
- (instancetype)initWithCls:(Class)viewClass didEnterReusePoolMessage:(SEL)didEnterReusePoolMessage willLeaveReusePoolMessage:(SEL)willLeaveReusePoolMessage{
    self = [super init];
    if (self) {
        _inner = CKComponentViewClass(viewClass, didEnterReusePoolMessage, willLeaveReusePoolMessage);
    }
    return self;
}
- (instancetype)initWithFactory:(CKWViewFactoryType)factory didEnterReusePool:(CKWViewReuseBlock)didEnterReusePool willLeaveReusePool:(CKWViewReuseBlock)willLeaveReusePool{

    self = [super init];
    if (self) {
        _inner = CKComponentViewClass(factory, didEnterReusePool, willLeaveReusePool);
    }
    return self;
}

- (CKComponentViewClass)convert {
    return _inner;
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if ([other isKindOfClass:CKWViewClass.class]){
        return _inner == ((CKWViewClass *)other).convert;
    }
    return NO;
}

@end


/// CKComponentViewAttribute have no default initializer, which cannot used as property in Objc class.
/// so we write a wrapper.
struct _CKComponentViewAttribute {
    _CKComponentViewAttribute(): inner(CKComponentViewAttribute(@selector(setTag:))) {};
    _CKComponentViewAttribute(CKComponentViewAttribute real):inner(real){}
    CKComponentViewAttribute inner;
};

@implementation CKWViewAttributeBase
@end

@implementation CKWViewAttribute {
    _CKComponentViewAttribute _inner;
}

- (instancetype)initWithSetter:(SEL)setter {
    self = [super init];
    if (self) {
        _inner = _CKComponentViewAttribute(CKComponentViewAttribute(setter));
    }
    return self;
}
- (instancetype)initWithLayerSetter:(SEL)setter {
    self = [super init];
    if (self) {
        _inner = _CKComponentViewAttribute(CKComponentViewAttribute::LayerAttribute(setter));
    }
    return self;
}
- (instancetype)initWithIdentifierString:(NSString *)string
                              applicator:(void (^)(id view, id value))applicator
                            unapplicator:(void (^)(id view, id value))unapplicator
                                 updater:(void (^)(id view, id oldValue, id newValue))updater
{
    self = [super init];
    if (self) {
        std::string identifier = std::string(string.UTF8String);
        _inner = _CKComponentViewAttribute(CKComponentViewAttribute(identifier, applicator, unapplicator, updater));
    }
    return self;
}

- (CKComponentViewAttribute)convert {
    return _inner.inner;
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if ([other isKindOfClass:CKWViewAttribute.class]){
        return _inner.inner == ((CKWViewAttribute *)other).convert;
    }
    return NO;
}

- (NSUInteger)hash {
    return std::hash<CKComponentViewAttribute>()(_inner.inner);
}
@end


@implementation CKWAccessibilityTextAttribute {
    CKComponentAccessibilityTextAttribute _inner;
}
- (instancetype)initWithText:(NSString *)text {
    self = [super init];
    if (self) {
        _inner = CKComponentAccessibilityTextAttribute(text);
    }
    return self;
}
- (instancetype)initWithLazyTextBlock:(NSString *(^)())textBlock {
    self = [super init];
    if (self) {
        _inner = CKComponentAccessibilityTextAttribute(textBlock);
    }
    return self;
}
- (BOOL)hasText {
    return _inner.hasText();
}
- (NSString *)value {
    return _inner.value();
}
- (CKComponentAccessibilityTextAttribute)convert {
    return _inner;
}
@end


@implementation CKWAccessibilityContext
- (CKComponentAccessibilityContext)convert {
    var c = CKComponentAccessibilityContext();
    c.isAccessibilityElement = self.isAccessibilityElement;
    c.accessibilityComponentAction = self.accessibilityComponentAction;
    c.accessibilityLabel = self.accessibilityLabel.convert;
    return c;
}
@end


CKViewComponentAttributeValueMap convertViewAttributesMap(CKWViewAttributeMap *attrs) {
    __block CKViewComponentAttributeValueMap map = CKViewComponentAttributeValueMap();
    [attrs enumerateKeysAndObjectsUsingBlock:^(CKWViewAttributeBase *key, id obj, BOOL *stop) {
        if ([key isKindOfClass:[CKWViewAttributeValueType class]]) {
            let k = (CKWViewAttributeValueType *)key;
            map.insert(k.convert);
        } else if ([key isKindOfClass:[CKWViewAttribute class]]) {
            let k = (CKWViewAttribute *)key;
            map[k.convert] = obj;
        } else  {
            assert(@"key must be CKWViewAttribute or CKWViewAttributeValueType");
        }
    }];
    return map;
}


@implementation CKWViewConfiguration

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithViewClass:(CKWViewClass *)cls
                viewAttributeMap:(NSDictionary<CKWViewAttributeBase *, id> *)viewAttributeMap {
    return [self initWithViewClass:cls viewAttributeMap:viewAttributeMap accessibilityContext:nil];
}
- (instancetype)initWithViewClass:(CKWViewClass *)cls
                viewAttributeMap:(NSDictionary<CKWViewAttributeBase *, id> *)viewAttributeMap
            accessibilityContext:(CKWAccessibilityContext *)context {
    self = [super init];
    if (self) {
        self.cls = cls;
        self.viewAttributeMap = viewAttributeMap;
        self.context = context;
    }
    return self;
}

- (CKComponentViewConfiguration)convert {
    CKViewComponentAttributeValueMap map = convertViewAttributesMap(self.viewAttributeMap);
    return CKComponentViewConfiguration(self.cls.convert, std::move(map), self.context.convert);
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if ([other isKindOfClass:CKWViewConfiguration.class]){
        return self.convert == ((CKWViewConfiguration *)other).convert;
    }
    return NO;
}

@end

