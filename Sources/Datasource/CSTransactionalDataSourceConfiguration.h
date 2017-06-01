//
//  CSTransactionalDataSourceConfiguration.h
//  Pods
//
//  Created by Gao on 31/05/2017.
//
//

#import <UIKit/UIKit.h>
#import "CSSize.h"
@protocol CSComponentProviderProtocol;

/// for CKTransactionalComponentDataSourceConfiguration
NS_SWIFT_NAME(DataSourceConfiguration)
@interface CSTransactionalDataSourceConfiguration : NSObject

@property (nonatomic, readonly, nullable) id context;
@property (nonatomic, readonly, nonnull) Class<CSComponentProviderProtocol> componentProvider;
@property (nonatomic, readonly) CGSizeRange sizeRange;

- (nonnull instancetype)initWithComponentProvider:(nonnull Class<CSComponentProviderProtocol>)componentProvider
                                          context:(nullable id)context
                                        sizeRange:(CGSizeRange)sizeRange;

- (nonnull instancetype)init NS_UNAVAILABLE;
@end
