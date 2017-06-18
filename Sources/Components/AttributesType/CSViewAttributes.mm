//
//  CSViewAttributes.m
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import "CSViewAttributes.h"
#import "CSObject+Convert.h"
#import <ComponentKit/ComponentKit.h>
#import "macro.h"

@implementation CSViewClass {
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
- (instancetype)initWithFactory:(CSViewFactoryType)factory didEnterReusePool:(CSViewReuseBlock)didEnterReusePool willLeaveReusePool:(CSViewReuseBlock)willLeaveReusePool{

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
    } else if ([other isKindOfClass:CSViewClass.class]){
        return _inner == ((CSViewClass *)other).convert;
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


@implementation CSViewAttribute {
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
    } else if ([other isKindOfClass:CSViewAttribute.class]){
        return _inner.inner == ((CSViewAttribute *)other).convert;
    }
    return NO;
}

- (NSUInteger)hash {
    return std::hash<CKComponentViewAttribute>()(_inner.inner);
}

- (id)copyWithZone:(NSZone *)zone {
    CSViewAttribute *c = [[CSViewAttribute alloc] init];
    c->_inner = _inner;
    return c;
}

@end


@implementation CSViewAttributeValue
- (CKComponentViewAttributeValue)convert {
    return {self.key.convert, self.value};
}
@end





@implementation CSViewAttributeMap {
    NSArray<CSViewAttributeValue *> *_content;
}

- (instancetype)initWithItems:(NSArray<CSViewAttributeValue *> *)items {
    self = [super init];
    if (self) {
        _content = items; // the dict bridged from swift dict will not copy keys, which is efficient.
    }
    return self;
}
- (NSArray<CSViewAttributeValue *> *)content {
    if (!_content) {
        _content = @[];
    }
    return _content;
}

- (CKViewComponentAttributeValueMap)convert {
    if (_content.count == 0) {
        return {};
    }
    CKViewComponentAttributeValueMap map = CKViewComponentAttributeValueMap();
    for (CSViewAttributeValue *value in _content) {
        map.insert(value.convert);
    }
    return map;
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if ([other isKindOfClass:CSViewAttributeMap.class]){
        return self.convert == ((CSViewAttributeMap *)other).convert;
    }
    return NO;
}


@end


@implementation CSViewConfiguration

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithViewClass:(CSViewClass *)cls
                viewAttributeMap:(CSViewAttributeMap *)viewAttributeMap {
    return [self initWithViewClass:cls viewAttributeMap:viewAttributeMap accessibilityContext:nil];
}
- (instancetype)initWithViewClass:(CSViewClass *)cls
                viewAttributeMap:(CSViewAttributeMap *)viewAttributeMap
            accessibilityContext:(CSAccessibilityContext *)context {
    self = [super init];
    if (self) {
        self.cls = cls;
        self.viewAttributeMap = viewAttributeMap;
        self.context = context;
    }
    return self;
}

- (CKComponentViewConfiguration)convert {
    return CKComponentViewConfiguration(self.cls.convert, self.viewAttributeMap.convert, self.context.convert);
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if ([other isKindOfClass:CSViewConfiguration.class]){
        return self.convert == ((CSViewConfiguration *)other).convert;
    }
    return NO;
}

@end

