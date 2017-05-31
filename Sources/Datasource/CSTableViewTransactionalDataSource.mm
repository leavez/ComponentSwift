//
//  CSTableViewTransactionalDataSource.m
//  Pods
//
//  Created by Gao on 16/05/2017.
//
//

#import "CSTableViewTransactionalDataSource.h"
#import <CKTableViewTransactionalDataSource/CKTableViewTransactionalDataSource.h>
#import "macro.h"
#import "CSChangeSet+Build.h"
#import "CSObject+Convert.h"


@implementation CSTableViewCellConfiguration

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
    CSTableViewCellConfiguration *config = [[self alloc] init];
    config.animationSectionInsert =
    config.animationSectionDelete =
    config.animationRowInsert =
    config.animationRowDelete = UITableViewRowAnimationNone;
    config.animationsDisabled = YES;
    return config;
}

@end





@implementation CSTableViewTransactionalDataSource  {
    CKTableViewTransactionalDataSource *_innerDatasource;
    CSTransactionalDataSourceConfiguration *_config;
    CSTableViewCellConfiguration *_cellConfig;
}

- (instancetype)initWithTableView:(UITableView *)tableView
                    configuration:(CSTransactionalDataSourceConfiguration *)configuration
      supplementaryViewDataSource:(nullable id<CSTableViewSupplementaryDataSource>)supplementaryViewDataSource
                cellConfiguration:(CSTableViewCellConfiguration *)cellConfiguration
{
    self = [super init];
    if (self) {

        let castedSupplementary = (id<CKTableViewSupplementaryDataSource>)supplementaryViewDataSource; // force cast

        let config = configuration.convert;

        _innerDatasource =
        [[CKTableViewTransactionalDataSource alloc]
         initWithTableView:tableView
         supplementaryDataSource:castedSupplementary
         configuration:config
         defaultCellConfiguration:cellConfiguration.convert];

        // save for later
        _config = configuration;
        _cellConfig = cellConfiguration;
    }
    return self;
}

- (UITableView *)tableView {
    return _innerDatasource.tableView;
}


- (void)applyChangeset:(CSChangeSet *)changeset asynchronously:(BOOL)asynchronously cellConfiguration:(CSTableViewCellConfiguration *)cellConfiguration {
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

- (void)updateConfiguration:(CSTransactionalDataSourceConfiguration *)configuration
          cellConfiguration:(CSTableViewCellConfiguration *)cellConfiguration
             asynchronously:(BOOL)asynchronously
{
    [_innerDatasource updateConfiguration:configuration.convert mode:asynchronously ? CKUpdateModeAsynchronous : CKUpdateModeSynchronous cellConfiguration:cellConfiguration.convert];
}

- (void)updateSizeRange:(CGSizeRange)sizeRange asynchronously:(BOOL)asynchronously {
    let config = [[CSTransactionalDataSourceConfiguration alloc] initWithComponentProvider:_config.componentProvider context:_config.context sizeRange:sizeRange];
    [self updateConfiguration:config cellConfiguration:_cellConfig asynchronously:asynchronously];
    _config = config;
}

@end




