//
//  CSSize.h
//  Pods
//
//  Created by Gao on 23/04/2017.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// for CKRelativeDimension.
NS_SWIFT_NAME(LayoutDimension)
@interface CSDimension : NSObject
- (instancetype)init; //Auto
- (instancetype)initWithPoint:(CGFloat)p;
- (instancetype)initWithPercent:(CGFloat)p;
- (instancetype)initWithFloatLiteral:(double)value; // for adopt ExpressibleByFloatLiteral in swift
- (instancetype)initWithIntegerLiteral:(NSInteger)value; // for adopt ExpressibleByIntegerLiteral in swift



@end


// for CKComponentSize
NS_SWIFT_NAME(LayoutSize)
@interface CSSize : NSObject

@property (nonatomic, nullable) CSDimension *width;
@property (nonatomic, nullable) CSDimension *height;

@property (nonatomic, nullable) CSDimension *minWidth;
@property (nonatomic, nullable) CSDimension *minHeight;

@property (nonatomic, nullable) CSDimension *maxWidth;
@property (nonatomic, nullable) CSDimension *maxHeight;

- (instancetype)initWithCGSize:(CGSize)size;

@end

struct CGSizeRange {
    CGSize min;
    CGSize max;
};
typedef struct CGSizeRange CGSizeRange;

NS_ASSUME_NONNULL_END
