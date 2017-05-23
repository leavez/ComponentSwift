//
//  WrapAExistedComponent.h
//  Pods
//
//  Created by Gao on 05/05/2017.
//
//

#import <ComponentSwift/ComponentSwift.h>

@interface FadeNetworkImageComponent : CSCompositeComponent

- (nonnull instancetype)initWithURL:(nullable NSURL *)url
                   imageDownloader:(nullable id)imageDownloader
                         scenePath:(nullable id)scenePath
                              size:(nullable CSSize *)size
                  placeholderImage:(nullable UIImage *)placeholderImage
                        attributes:(nullable CSViewAttributeMap *)attributes
                         endurance:(NSTimeInterval)endurance
                transitionDuration:(NSTimeInterval)transitionDuration;

@end
