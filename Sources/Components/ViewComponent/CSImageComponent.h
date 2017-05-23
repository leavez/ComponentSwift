//
//  CSImageComponent.h
//  Pods
//
//  Created by Gao on 05/05/2017.
//
//

#import "CSComponent.h"

/// for CKImageComponent.
NS_SWIFT_NAME(ImageComponnet)
@interface CSImageComponent : CSComponent

/**
 Uses a static layout with the image's size.
 */
- (nonnull instancetype)initWithImage:(nullable UIImage *)image;

/**
 Uses a static layout with the given image size.
 */
- (nonnull instancetype)initWithImage:(nullable UIImage *)image
                                 size:(nullable CSSize *)size;

@end
