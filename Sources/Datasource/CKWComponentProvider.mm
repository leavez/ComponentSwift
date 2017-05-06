//
//  CKWComponentProvider.m
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

#import "CKWComponentProvider.h"
#import <ComponentKit/ComponentKit.h>
#import "CKWComponentInner.h"


/**
    Implement CKComponentProvider for NSObject, so it could use the content of CKWComponentProviderProtocol.
 */
@interface NSObject (CKDatasource)<CKComponentProvider>
@end

@implementation NSObject (CKDatasource)

+ (CKComponent *)componentForModel:(nonnull id<NSObject>)model context:(nullable id<NSObject>)context {
    if ([self conformsToProtocol:@protocol(CKWComponentProviderProtocol)]) {
        Class<CKWComponentProviderProtocol> c = (Class<CKWComponentProviderProtocol>)self;
        CKWComponent *wrapped = [c ckwComponentForModel:model context:context];
        // handle a
        CKComponent *real = wrapped.realComponent;
        return real;
    } else {
        NSAssert(NO, @"not confirm to protocol");
        return nil;
    }
}

@end
