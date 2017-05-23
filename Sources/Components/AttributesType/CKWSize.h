//
//  CKWSize.h
//  Pods
//
//  Created by Gao on 23/04/2017.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// for CKRelativeDimension.
NS_SWIFT_NAME(LayoutDimension)
@interface CKWDimension : NSObject
- (instancetype)init; //Auto
- (instancetype)initWithPoint:(CGFloat)p;
- (instancetype)initWithPercent:(CGFloat)p;
- (instancetype)initWithFloatLiteral:(double)value; // for adopt ExpressibleByFloatLiteral in swift

@end



NS_SWIFT_NAME(LayoutSize)
@interface CKWSize : NSObject

@property (nonatomic, nullable) CKWDimension *width;
@property (nonatomic, nullable) CKWDimension *height;

@property (nonatomic, nullable) CKWDimension *minWidth;
@property (nonatomic, nullable) CKWDimension *minHeight;

@property (nonatomic, nullable) CKWDimension *maxWidth;
@property (nonatomic, nullable) CKWDimension *maxHeight;

- (instancetype)initWithCGSize:(CGSize)size;

@end

struct CGSizeRange {
    CGSize min;
    CGSize max;
};
typedef struct CGSizeRange CGSizeRange;

NS_ASSUME_NONNULL_END
