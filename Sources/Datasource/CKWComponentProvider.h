//
//  CKWComponentProvider.h
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

#import "CKWComponent.h"

/// for CKComponentProvider.
NS_SWIFT_NAME(ComponentProvider)
@protocol CKWComponentProviderProtocol <NSObject>

+ (nullable CKWComponent *)ckwComponentForModel:(nonnull id<NSObject>)model context:(nullable id<NSObject>)context;

@end

