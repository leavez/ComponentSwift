//
//  CSNetworkImageComponent.m
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

#import "CSNetworkImageComponent.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"
#import "macro.h"

@implementation CSNetworkImageComponent

- (instancetype)initWithURL:(NSURL *)url imageDownloader:(id<CSNetworkImageDownloading>)imageDownloader size:(CSSize *)size placeholderImage:(UIImage *)placeholderImage cropRect:(CGRect)cropRect attributes:(CSViewAttributeMap *)attributes
{
    self = [super init];
    if (self) {

        self.realComponent = [CKNetworkImageComponent
                              newWithURL:url
                              imageDownloader:(id<CKNetworkImageDownloading>)imageDownloader
                              size:ConvertWithDefault(size, CKComponentSize())
                              options:{
                                  .defaultImage = placeholderImage,
                                  .cropRect = cropRect,
                              } attributes:ConvertWithDefault(attributes, CKViewComponentAttributeValueMap())];
    }
    return self;
}

@end
