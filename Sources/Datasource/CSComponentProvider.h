//
//  CSComponentProvider.h
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

#import "CSComponent.h"

/// for CKComponentProvider.
NS_SWIFT_NAME(ComponentProviderProtocol)
@protocol CSComponentProviderProtocol <NSObject>

+ (nullable CSComponent *)CSComponentForModel:(nonnull id)model context:(nullable id)context;

@end

