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
@interface CKWDimension : NSObject
- (instancetype)init; //Auto
- (instancetype)initWithPoint:(CGFloat)p;
- (instancetype)initWithPercent:(CGFloat)p;
- (instancetype)initWithFloatLiteral:(double)value; // for adopt ExpressibleByFloatLiteral in swift

@end



@interface CKWSize : NSObject

@property (nonatomic, nullable) CKWDimension *width;
@property (nonatomic, nullable) CKWDimension *height;

@property (nonatomic, nullable) CKWDimension *minWidth;
@property (nonatomic, nullable) CKWDimension *minHeight;

@property (nonatomic, nullable) CKWDimension *maxWidth;
@property (nonatomic, nullable) CKWDimension *maxHeight;

- (instancetype)init;
- (instancetype)initWithCGSize:(CGSize)size;

@end
NS_ASSUME_NONNULL_END
