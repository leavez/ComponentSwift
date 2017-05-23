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
    return [self initWithImage:image size:[[CSSize alloc] initWithCGSize:image.size]];
}

- (instancetype)initWithImage:(UIImage *)image size:(CSSize *)size {

    self = [super init];
    if (self) {
        self.realComponent = [CKImageComponent newWithImage:image size:ConvertWithDefault(size, CKComponentSize())];
    }
    return self;
}

@end
