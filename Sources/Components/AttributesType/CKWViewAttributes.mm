//
//  CKWViewAttributes.m
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import "CKWViewAttributes.h"
#import "CKWViewAttribute+Inner.h"
#import <ComponentKit/ComponentKit.h>
#import "macro.h"

@implementation CKWViewClass

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithCls:(Class)viewClass {
    return [self initWithCls:viewClass didEnterReusePoolMessage:nil willLeaveReusePoolMessage:nil];
}
- (instancetype)initWithCls:(Class)viewClass didEnterReusePoolMessage:(SEL)didEnterReusePoolMessage willLeaveReusePoolMessage:(SEL)willLeaveReusePoolMessage{
    self = [super init];
    if (self) {
        self.viewClass = viewClass;
        self.didEnterReusePoolMessage = didEnterReusePoolMessage;
        self.willLeaveReusePoolMessage = willLeaveReusePoolMessage;
    }
    return self;
}
- (instancetype)initWithFactory:(CKWViewFactoryType)factory didEnterReusePool:(CKWViewReuseBlock)didEnterReusePool willLeaveReusePool:(CKWViewReuseBlock)willLeaveReusePool{

    self = [super init];
    if (self) {
        self.factory = factory;
        self.didEnterReusePool = didEnterReusePool;
        self.willLeaveReusePool = willLeaveReusePool;
    }
    return self;
}

- (CKComponentViewClass)convert {
    if (self.factory) {
        return CKComponentViewClass(
                                    self.factory,
                                    self.didEnterReusePool,
                                    self.willLeaveReusePool
                                    );
    } else {
        return CKComponentViewClass(
                                    self.viewClass,
                                    self.didEnterReusePoolMessage,
                                    self.willLeaveReusePoolMessage
                                    );
    }
}

@end

CKComponentViewClass::CKComponentViewClass() {
}


@implementation CKWViewAttribute {
    SEL _setter;
    SEL _laySetter;
}

- (instancetype)initWithSetter:(SEL)setter {
    self = [super init];
    if (self) {
        _setter = setter;
    }
    return self;
}
- (instancetype)initWithLayerSetter:(SEL)setter {
    self = [super init];
    if (self) {
        _laySetter = setter;
    }
    return self;
}
- (CKComponentViewAttribute)convert {
    if (_laySetter) {
        return  CKComponentViewAttribute::LayerAttribute(_laySetter);
    } else {
        return CKComponentViewAttribute(_setter);
    }
}
@end




@implementation CKWAccessibilityContext
- (CKComponentAccessibilityContext)convert {
    var c = CKComponentAccessibilityContext();
    c.isAccessibilityElement = self.isAccessibilityElement;
    c.accessibilityComponentAction = self.accessibilityComponentAction;
    return c;
}
@end



@implementation CKWViewConfiguration

- (instancetype)init {
    return [super init];
}

- (instancetype)initWithViewClass:(CKWViewClass *)cls
                viewAttributeMap:(NSDictionary<CKWViewAttribute *, id> *)viewAttributeMap {
    return [self initWithViewClass:cls viewAttributeMap:viewAttributeMap accessibilityContext:nil];
}
- (instancetype)initWithViewClass:(CKWViewClass *)cls
                viewAttributeMap:(NSDictionary<CKWViewAttribute *, id> *)viewAttributeMap
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

    __block CKViewComponentAttributeValueMap map = CKViewComponentAttributeValueMap();
    [self.viewAttributeMap enumerateKeysAndObjectsUsingBlock:^(CKWViewAttribute * key, id obj, BOOL *stop) {
        if ([key isKindOfClass:[CKWGestureAttribute class]]) {
            let k = (CKWGestureAttribute *)key;
            map.insert(k.convert);
        } else {
            map[key.convert] = obj;
        }
    }];
    return CKComponentViewConfiguration(self.cls.convert, std::move(map), self.context.convert);
}

@end

