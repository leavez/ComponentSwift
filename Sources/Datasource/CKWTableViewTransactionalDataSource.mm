//
//  CKWTableViewTransactionalDataSource.m
//  Pods
//
//  Created by Gao on 16/05/2017.
//
//

#import "CKWTableViewTransactionalDataSource.h"
#import <CKTableViewTransactionalDataSource/CKTableViewTransactionalDataSource.h>
#import "macro.h"
#import "CKWChangeSet+Build.h"


@implementation CKWTableViewCellConfiguration

- (CKTableViewTransactionalDataSourceCellConfiguration *)convert {
    let config = [[CKTableViewTransactionalDataSourceCellConfiguration alloc] init];
    config.animationRowDelete = self.animationRowDelete;
    config.animationRowInsert = self.animationRowInsert;
    config.animationSectionDelete = self.animationSectionDelete;
    config.animationSectionInsert = self.animationSectionInsert;
    config.animationsDisabled = self.animationsDisabled;
    config.cellConfigurationFunction = self.cellConfigurationFunction;
    return config;
}

+ (instancetype)noAnimationConfig {
    CKWTableViewCellConfiguration *config = [[self alloc] init];
    config.animationSectionInsert =
    config.animationSectionDelete =
    config.animationRowInsert =
    config.animationRowDelete = UITableViewRowAnimationNone;
    config.animationsDisabled = YES;
    return config;
}

@end





@implementation CKWTableViewTransactionalDataSource  {
    CKTableViewTransactionalDataSource *_innerDatasource;
}

- (instancetype)initWithTableView:(UITableView *)tableView
      supplementaryViewDataSource:(id<CKWTableViewSupplementaryDataSource>)supplementaryViewDataSource
                componentProvider:(Class<CKWComponentProviderProtocol>)componentProvider
                          context:(id)context
                cellConfiguration:(CKWTableViewCellConfiguration *)cellConfiguration
                          minSize:(CGSize)minSize maxSize:(CGSize)maxSize
{
    self = [super init];
    if (self) {
        Class provider = componentProvider;
        NSAssert([provider isSubclassOfClass:[NSObject class]], @"%@ should be sublcass of NSObject", NSStringFromClass(provider));

        let castedComponentProviderClass = (Class<CKComponentProvider>)provider;
        let castedSupplementary = (id<CKTableViewSupplementaryDataSource>)supplementaryViewDataSource; // force cast

        let config = [[CKTransactionalComponentDataSourceConfiguration alloc]
                      initWithComponentProvider:castedComponentProviderClass
                      context:context
                      sizeRange:CKSizeRange(minSize, maxSize)];

        _innerDatasource =
        [[CKTableViewTransactionalDataSource alloc]
         initWithTableView:tableView
         supplementaryDataSource:castedSupplementary
         configuration:config
         defaultCellConfiguration:cellConfiguration.convert];
    }
    return self;
}

- (UITableView *)tableView {
    return _innerDatasource.tableView;
}


- (void)applyChangeset:(CKWChangeSet *)changeset asynchronously:(BOOL)asynchronously cellConfiguration:(CKWTableViewCellConfiguration *)cellConfiguration {
    [_innerDatasource applyChangeset:changeset.build mode:asynchronously ? CKUpdateModeAsynchronous : CKUpdateModeSynchronous cellConfiguration:cellConfiguration.convert];
}

- (id<NSObject>)modelForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_innerDatasource modelForItemAtIndexPath:indexPath];
}

- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return [_innerDatasource sizeForItemAtIndexPath:indexPath];
}

- (void)reloadAsynchronously:(BOOL)asynchronously userInfo:(NSDictionary *)userInfo {
    [_innerDatasource reloadWithMode:asynchronously ? CKUpdateModeAsynchronous : CKUpdateModeSynchronous userInfo:userInfo];
}


@end




