//
//  CKWNetworkImageComponnet.m
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

#import "CKWNetworkImageComponnet.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"
#import "macro.h"

@implementation CKWNetworkImageComponnet

- (instancetype)initWithURL:(NSURL *)url imageDownloader:(id<CKWNetworkImageDownloading>)imageDownloader scenePath:(id)scenePath size:(CKWSize *)size placeholderImage:(UIImage *)placeholderImage cropRect:(CGRect)cropRect attributes:(CKWViewAttributeMap *)attributes
{
    self = [super init];
    if (self) {
        self.realComponent = [CKNetworkImageComponent
                              newWithURL:url
                              imageDownloader:(id<CKNetworkImageDownloading>)imageDownloader
                              scenePath:scenePath
                              size:ConvertWithDefault(size, CKComponentSize())
                              options:{
                                  .defaultImage = placeholderImage,
                                  .cropRect = cropRect,
                              } attributes:ConvertWithDefault(attributes, CKViewComponentAttributeValueMap())];
    }
    return self;
}

@end
