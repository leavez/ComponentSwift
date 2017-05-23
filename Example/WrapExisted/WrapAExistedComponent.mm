//
//  WrapAExistedComponent.m
//  Pods
//
//  Created by Gao on 05/05/2017.
//
//

#import "WrapAExistedComponent.h"
#import <ComponentSwift/ComponentSubclass.h>
#import "CKFadeNetworkImageComponent.h"

@implementation FadeNetworkImageComponent

-(instancetype)initWithURL:(NSURL *)url imageDownloader:(id<CKNetworkImageDownloading>)imageDownloader scenePath:(id)scenePath size:(CSSize *)size placeholderImage:(UIImage *)placeholderImage attributes:(CSViewAttributeMap *)attributes endurance:(NSTimeInterval)endurance transitionDuration:(NSTimeInterval)transitionDuration
{
    CKComponent *component = [CKFadeNetworkImageComponent
                              newWithURL:url
                              imageDownloader:imageDownloader
                              scenePath:scenePath
                              size:ConvertWithDefault(size, CKComponentSize())
                              placeholderImage:placeholderImage
                              attributes:ConvertWithDefault(attributes, CKViewComponentAttributeValueMap())
                              endurance:endurance
                              transitionDuration:transitionDuration];

    return [super initWithCKComponent:component];
}

@end
