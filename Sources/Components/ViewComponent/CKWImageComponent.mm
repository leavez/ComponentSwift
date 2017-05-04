//
//  CKWImageComponent.m
//  Pods
//
//  Created by Gao on 05/05/2017.
//
//

#import "CKWImageComponent.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"
#import "macro.h"

@implementation CKWImageComponent

- (instancetype)initWithImage:(UIImage *)image {
    return [self initWithImage:image size:[[CKWSize alloc] initWithCGSize:image.size]];
}

- (instancetype)initWithImage:(UIImage *)image size:(CKWSize *)size {

    self = [super init];
    if (self) {
        self.realComponent = [CKImageComponent newWithImage:image size:ConvertWithDefault(size, CKComponentSize())];
    }
    return self;
}

@end
