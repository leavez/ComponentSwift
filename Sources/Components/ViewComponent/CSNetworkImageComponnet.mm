//
//  CSNetworkImageComponnet.m
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

#import "CSNetworkImageComponnet.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"
#import "macro.h"

@implementation CSNetworkImageComponnet

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
