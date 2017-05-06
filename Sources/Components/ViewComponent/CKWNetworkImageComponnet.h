//
//  CKWNetworkImageComponnet.h
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

#import "CKWrapper.h"
@protocol CKWNetworkImageDownloading;


/// for CKNetworkImageComponent
NS_SWIFT_NAME(NetworkImageComponnet)
@interface CKWNetworkImageComponnet : CKWComponent

// @param cropRect Optional rectangle (in the unit coordinate space) that specifies the portion of contents that the receiver should draw.
- (nonnull instancetype)initWithURL:(nullable NSURL *)url
                    imageDownloader:(nonnull id<CKWNetworkImageDownloading>)imageDownloader
                          scenePath:(nullable id)scenePath
                               size:(nullable CKWSize *)size
                   placeholderImage:(nullable UIImage *)placeholderImage
                           cropRect:(CGRect)cropRect
                         attributes:(nullable CKWViewAttributeMap *)attributes NS_REFINED_FOR_SWIFT;

@end



/** Downloads images for a network image component. */
@protocol CKWNetworkImageDownloading <NSObject>
@required

/**
 @abstract Downloads an image with the given URL.
 @param URL The URL of the image to download.
 @param scenePath Opaque context for where this is from.
 @param caller The object that initiated the request.
 @param callbackQueue The queue to call `downloadProgressBlock` and `completion` on. If this value is nil, both blocks will be invoked on the main-queue.
 @param downloadProgressBlock The block to be invoked when the download of `URL` progresses. progress: The progress of the download, in the range of (0.0, 1.0), inclusive.
 @param completion The block to be invoked when the download has completed, or has failed. image: The image that was downloaded, if the image could be successfully downloaded; nil otherwise. error: An error describing why the download of `URL` failed, if the download failed; nil otherwise.
 @discussion If `URL` is nil, `completion` will be invoked immediately with a nil image and an error describing why the download failed.
 @result An opaque identifier to be used in canceling the download, via `cancelImageDownload:`. You must retain the identifier if you wish to use it later.
 */
- (nonnull id)downloadImageWithURL:(nullable NSURL *)URL
                         scenePath:(_Nullable id)scenePath
                            caller:(_Nullable id)caller
                     callbackQueue:(nonnull dispatch_queue_t)callbackQueue
             downloadProgressBlock:(void (^_Nonnull)(CGFloat progress))downloadProgressBlock
                        completion:(void (^_Nonnull)(CGImageRef _Nullable image, NSError * _Nullable error))completion;

/**
 @abstract Cancels an image download.
 @param download The opaque download identifier object returned from `downloadImageWithURL:scenePath:caller:callbackQueue:downloadProgressBlock:completion:`.
 @discussion This method has no effect if `download` is nil.
 */
- (void)cancelImageDownload:(_Nullable id)download;

@end
