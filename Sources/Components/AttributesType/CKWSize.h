//
//  CKWSize.h
//  Pods
//
//  Created by Gao on 23/04/2017.
//
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CKWDimension : NSObject
- (instancetype)init; //Auto
- (instancetype)initWithPoint:(CGFloat)p;
- (instancetype)initWithPercent:(CGFloat)p;
@end



@interface CKWSize : NSObject

@property (nonatomic, nullable) CKWDimension *width;
@property (nonatomic, nullable) CKWDimension *height;

@property (nonatomic, nullable) CKWDimension *minWidth;
@property (nonatomic, nullable) CKWDimension *minHeight;

@property (nonatomic, nullable) CKWDimension *maxWidth;
@property (nonatomic, nullable) CKWDimension *maxHeight;

- (instancetype)initWithCGSize:(CGSize)size;

@end
NS_ASSUME_NONNULL_END
