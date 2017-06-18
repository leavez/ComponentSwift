//
//  CSImageComponent.m
//  Pods
//
//  Created by Gao on 05/05/2017.
//
//

#import "CSImageComponent.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"
#import "macro.h"

@implementation CSImageComponent

- (instancetype)initWithImage:(UIImage *)image {
    return [self initWithImage:image contentMode:UIViewContentModeScaleAspectFill attributes:nil size:[[CSSize alloc] initWithCGSize:image.size]];
}

- (instancetype)initWithImage:(UIImage *)image contentMode:(UIViewContentMode)mode                            attributes:(nullable CSViewAttributeMap *)attributes size:(CSSize *)size {

    CKViewComponentAttributeValueMap copied = ConvertWithDefault(attributes, CKViewComponentAttributeValueMap());
    copied.insert({
        {@selector(setImage:), image},
        {@selector(setContentMode:) , @(mode)},
    });
    var key = @selector(setClipsToBounds:);
    if (copied[key] == nil) {
        copied[key] = @YES;
    }

    self = [super init];
    if (self) {
        self.realComponent = [CKComponent newWithView:{
            [UIImageView class],
            copied
        } size:ConvertWithDefault(size, CKComponentSize())];
    }
    return self;
}

@end
