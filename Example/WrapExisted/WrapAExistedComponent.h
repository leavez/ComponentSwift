//
//  WrapAExistedComponent.h
//  Pods
//
//  Created by Gao on 05/05/2017.
//
//

#import <CKWrapper/CKWrapper.h>

@interface FadeNetworkImageComponent : CKWCompositeComponent

- (nonnull instancetype)initWithURL:(nullable NSURL *)url
                   imageDownloader:(nullable id)imageDownloader
                         scenePath:(nullable id)scenePath
                              size:(nullable CKWSize *)size
                  placeholderImage:(nullable UIImage *)placeholderImage
                        attributes:(nullable CKWViewAttributeMap *)attributes
                         endurance:(NSTimeInterval)endurance
                transitionDuration:(NSTimeInterval)transitionDuration;

@end
