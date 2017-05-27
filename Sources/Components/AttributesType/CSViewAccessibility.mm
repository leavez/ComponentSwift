//
//  CSViewAccessibility.m
//  Pods
//
//  Created by Gao on 27/05/2017.
//
//

#import "CSViewAccessibility.h"
#import <ComponentKit/ComponentKit.h>
#import "CSObject+Convert.h"
#import "macro.h"

@implementation CSAccessibilityTextAttribute {
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


@implementation CSAccessibilityContext
- (CKComponentAccessibilityContext)convert {
    var c = CKComponentAccessibilityContext();
    c.isAccessibilityElement = self.isAccessibilityElement;
    c.accessibilityComponentAction = self.accessibilityComponentAction;
    c.accessibilityLabel = self.accessibilityLabel.convert;
    return c;
}
@end
