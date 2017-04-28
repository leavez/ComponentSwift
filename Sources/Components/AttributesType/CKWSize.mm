//
//  CKWSize.m
//  Pods
//
//  Created by Gao on 23/04/2017.
//
//

#import "CKWSize.h"
#import <ComponentKit/ComponentKit.h>
#import "CKWViewAttribute+Inner.h"

@implementation CKWDimension {
    CKRelativeDimension _inner;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        _inner = CKRelativeDimension();
    }
    return self;
}
- (instancetype)initWithPoint:(CGFloat)p {
    self = [super init];
    if (self) {
        _inner = CKRelativeDimension(p);
    }
    return self;
}
- (instancetype)initWithPercent:(CGFloat)p {
    self = [super init];
    if (self) {
        _inner = CKRelativeDimension::Percent(p);
    }
    return self;
}

- (instancetype)initWithFloatLiteral:(double)value {
    return [self initWithPoint:value];
}

- (CKRelativeDimension)convert {
    return _inner;
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if ([other isKindOfClass:CKWDimension.class]){
        return _inner == ((CKWDimension *)other).convert;
    }
    return NO;
}

- (NSUInteger)hash {
    return std::hash<CKRelativeDimension>()(_inner);
}

@end

@implementation CKWSize

- (instancetype)initWithCGSize:(CGSize)size {
    self = [super init];
    if (self) {
        _width = [[CKWDimension alloc] initWithPoint:size.width];
        _height = [[CKWDimension alloc] initWithPoint:size.height];
    }
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if ([other isKindOfClass:CKWSize.class]){
        return self.convert == ((CKWSize *)other).convert;
    }
    return NO;
}

- (NSUInteger)hash {
    return std::hash<CKComponentSize>()(self.convert);
}


- (CKComponentSize)convert {
    return (CKComponentSize) {
        .height = self.height.convert,
        .width = self.width.convert,
        .minWidth = self.minWidth.convert,
        .minHeight = self.minHeight.convert,
        .maxWidth = self.maxWidth.convert,
        .maxHeight = self.maxHeight.convert,
    };
}

@end
