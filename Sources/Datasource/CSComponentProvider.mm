//
//  CSComponentProvider.m
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

#import "CSComponentProvider.h"
#import <ComponentKit/ComponentKit.h>
#import "CSComponentInner.h"


/**
    Implement CKComponentProvider for NSObject, so it could use the content of CSComponentProviderProtocol.
 */
@interface NSObject (CKDatasource)<CKComponentProvider>
@end

@implementation NSObject (CKDatasource)

+ (CKComponent *)componentForModel:(nonnull id<NSObject>)model context:(nullable id<NSObject>)context {
    if ([self conformsToProtocol:@protocol(CSComponentProviderProtocol)]) {
        Class<CSComponentProviderProtocol> c = (Class<CSComponentProviderProtocol>)self;
        CSComponent *wrapped = [c CSComponentForModel:model context:context];
        // handle a
        CKComponent *real = wrapped.realComponent;
        return real;
    } else {
        NSAssert(NO, @"not confirm to protocol");
        return nil;
    }
}

@end
