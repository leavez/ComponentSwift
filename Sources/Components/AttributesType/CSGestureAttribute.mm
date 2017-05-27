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
        return self.class == g.class && self.action == g.action;
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

