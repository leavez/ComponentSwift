//
//  CSCollectionViewTransactionalDataSource.m
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

#import "CSCollectionViewTransactionalDataSource.h"
#import <ComponentKit/ComponentKit.h>
#import "macro.h"
#import "CSChangeSet+Build.h"
#import "CSObject+Convert.h"


@implementation CSCollectionViewTransactionalDataSource {
    CKCollectionViewTransactionalDataSource *_innerDatasource;
    CSTransactionalDataSourceConfiguration *_config;
}


- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
           supplementaryViewDataSource:(nullable id<CSSupplementaryViewDataSource>)supplementaryViewDataSource
                         configuration:(CSTransactionalDataSourceConfiguration *)configuration

{
    self = [super init];
    if (self) {

        let castedSupplementary = (id<CKSupplementaryViewDataSource>)supplementaryViewDataSource; // force cast

        let config = configuration.convert;

        _innerDatasource =
        [[CKCollectionViewTransactionalDataSource alloc]
         initWithCollectionView:collectionView
         supplementaryViewDataSource:castedSupplementary
         configuration:config];


        // save for later
        _config = configuration;
    }
    return self;
}

- (UICollectionView *)collectionView {
    return _innerDatasource.collectionView;
}

- (void)applyChangeset:(CSChangeSet *)changeset asynchronously:(BOOL)asynchronously userInfo:(NSDictionary *)userInfo {
    [_innerDatasource applyChangeset:changeset.build mode:asynchronously ? CKUpdateModeAsynchronous : CKUpdateModeSynchronous userInfo:userInfo];
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
             asynchronously:(BOOL)asynchronously userInfo:(NSDictionary *)userInfo {
    [_innerDatasource updateConfiguration:configuration.convert mode:asynchronously ? CKUpdateModeAsynchronous : CKUpdateModeSynchronous userInfo:userInfo];
}

- (void)updateSizeRange:(CGSizeRange)sizeRange asynchronously:(BOOL)asynchronously {
    let config = [[CSTransactionalDataSourceConfiguration alloc] initWithComponentProvider:_config.componentProvider context:_config.context sizeRange:sizeRange];
    [self updateConfiguration:config asynchronously:asynchronously userInfo:nil];
    _config = config;
}
@end
