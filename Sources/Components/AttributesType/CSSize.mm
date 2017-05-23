//
//  CSSize.m
//  Pods
//
//  Created by Gao on 23/04/2017.
//
//

#import "CSSize.h"
#import <ComponentKit/ComponentKit.h>
#import "CSObject+Convert.h"

@implementation CSDimension {
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
    } else if ([other isKindOfClass:CSDimension.class]){
        return _inner == ((CSDimension *)other).convert;
    }
    return NO;
}

- (NSUInteger)hash {
    return std::hash<CKRelativeDimension>()(_inner);
}

@end

@implementation CSSize

- (instancetype)initWithCGSize:(CGSize)size {
    self = [super init];
    if (self) {
        _width = [[CSDimension alloc] initWithPoint:size.width];
        _height = [[CSDimension alloc] initWithPoint:size.height];
    }
    return self;
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if ([other isKindOfClass:CSSize.class]){
        return self.convert == ((CSSize *)other).convert;
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
