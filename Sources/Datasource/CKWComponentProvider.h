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

+ (nullable CKWComponent *)ckwComponentForModel:(nonnull id)model context:(nullable id)context;

@end

