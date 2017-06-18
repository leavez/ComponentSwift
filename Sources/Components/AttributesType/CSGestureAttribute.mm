//
//  CSGestureAttribute.m
//  Pods
//
//  Created by Gao on 23/04/2017.
//
//

#import "CSGestureAttribute.h"
#import "CSObject+Convert.h"
#import "macro.h"


@interface CSGestureAttributeValue ()
@property (nonatomic, readwrite) Class gestureClass;
@property (nonatomic, readwrite) SEL action;
@end

@implementation CSGestureAttributeValue

- (CSViewAttribute *)attribute {
    NSAssert(NO, @"attribute is not available in this class");
    return [[CSViewAttribute alloc] init];
}
- (id)value {
    NSAssert(NO, @"value is not available in this class");
    return @0;
}

- (instancetype)initWithTapAction:(SEL)tapAction {
    self = [super init];
    if (self) {
        _action = tapAction;
        _gestureClass = [UITapGestureRecognizer class];
    }
    return self;
}
- (instancetype)initWithPanAction:(SEL)tapAction {
    self = [super init];
    if (self) {
        _action = tapAction;
        _gestureClass = [UIPanGestureRecognizer class];
    }
    return self;
}
- (instancetype)initWithLongPressAction:(SEL)tapAction {
    self = [super init];
    if (self) {
        _action = tapAction;
        _gestureClass = [UILongPressGestureRecognizer class];
    }
    return self;
}

- (CKComponentViewAttributeValue)convert {
    return CKComponentGestureAttribute(self.gestureClass, nullptr, self.action);
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if ([other isKindOfClass:CSGestureAttributeValue.class]){
        CSGestureAttributeValue *g = (CSGestureAttributeValue *)other;
        return self.gestureClass == g.gestureClass && self.action == g.action;
    }
    return NO;
}

- (NSUInteger)hash {
    return std::hash<CKViewComponentAttributeValueMap>()({self.convert});
}

- (id)copyWithZone:(NSZone *)zone {
    CSGestureAttributeValue *c = [[self.class alloc] init];
    c.action = self.action;
    c.gestureClass = self.gestureClass;
    return c;
}

@end


@implementation CSControlActionAttribute {
    UIControlEvents _event;
    SEL _action;
}
- (nonnull instancetype)initWithEvent:(UIControlEvents)event action:(nullable SEL)action {
    self = [super init];
    if (self) {
        _event = event;
        _action = action;
    }
    return self;
}

- (CKComponentViewAttributeValue)convert {
    return CKComponentActionAttribute(_action, _event);
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if ([other isKindOfClass:CSControlActionAttribute.class]){
        CSControlActionAttribute *g = (CSControlActionAttribute *)other;
        return g->_action == _action && g->_event == _event;
    }
    return NO;
}

- (NSUInteger)hash {
    return std::hash<CKViewComponentAttributeValueMap>()({self.convert});
}

- (id)copyWithZone:(NSZone *)zone {
    CSControlActionAttribute *c = [[self.class alloc] initWithEvent:_event action:_action];
    return c;
}
@end

