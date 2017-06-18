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
    return [self initWithImage:image contentMode:UIViewContentModeScaleAspectFill size:[[CSSize alloc] initWithCGSize:image.size]];
}

- (instancetype)initWithImage:(UIImage *)image contentMode:(UIViewContentMode)mode size:(CSSize *)size {

    self = [super init];
    if (self) {
        self.realComponent = [CKComponent newWithView:{
            [UIImageView class],
            {
                {@selector(setImage:), image},
                {@selector(setContentMode:) , @(mode)},
                {@selector(setClipsToBounds:), @YES}
            }
        } size:ConvertWithDefault(size, CKComponentSize())];
    }
    return self;
}

@end
