//
//  ZHCKNetworkImageComponent.h
//  Pods
//
//  Created by Gao on 11/3/16.
//
//
// modify verstion of CKNetworkImageComponent


#import <ComponentKit/CKComponent.h>
#import <ComponentKit/CKNetworkImageDownloading.h>


/** Renders an image from a URL and appear with dissovle effect. */
@interface CKFadeNetworkImageComponent : CKComponent

/**
 @param attributes Applied to the underlying UIImageView.
 */
+ (instancetype)newWithURL:(NSURL *)url
           imageDownloader:(id<CKNetworkImageDownloading>)imageDownloader
                 scenePath:(id)scenePath
                      size:(const CKComponentSize &)size
          placeholderImage:(UIImage *)placeholderImage
                attributes:(const CKViewComponentAttributeValueMap &)attributes
                 endurance:(NSTimeInterval)endurance
        transitionDuration:(NSTimeInterval)transitionDuration;

/**
 *  内部设置了 contentMode 为 UIViewContentModeScaleAspectFill
 */
+ (instancetype)newWithUrl:(NSString*)url
                      size:(CGSize)size
           placeholderImage:(UIImage *)placeholderImage
           imageDownloader:(id<CKNetworkImageDownloading>)downloader;

+ (instancetype)newWithUrl:(NSString*)url
                      size:(CGSize)size
          placeholderImage:(UIImage *)placeholderImage
                attributes:(const CKViewComponentAttributeValueMap &)attributes
           imageDownloader:(id<CKNetworkImageDownloading>)downloader;

+ (instancetype)newWithUrl:(NSString*)url
            sizeAttributes:(const CKComponentSize &)size
          placeholderImage:(UIImage *)placeholderImage
                attributes:(const CKViewComponentAttributeValueMap &)attributes
           imageDownloader:(id<CKNetworkImageDownloading>)downloader;

@end
