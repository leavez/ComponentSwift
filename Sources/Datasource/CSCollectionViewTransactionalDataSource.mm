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


@implementation CSCollectionViewTransactionalDataSource {
    CKCollectionViewTransactionalDataSource *_innerDatasource;
}

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
           supplementaryViewDataSource:(id<CSSupplementaryViewDataSource>)supplementaryViewDataSource
                     componentProvider:(Class<CSComponentProviderProtocol>)componentProvider
                               context:(id<NSObject>)context
                               minSize:(CGSize)minSize
                               maxSize:(CGSize)maxSize;
{
    self = [super init];
    if (self) {
        Class provider = componentProvider;
        NSAssert([provider isSubclassOfClass:[NSObject class]], @"%@ should be sublcass of NSObject", NSStringFromClass(provider));

        let castedComponentProviderClass = (Class<CKComponentProvider>)provider;
        let castedSupplementary = (id<CKSupplementaryViewDataSource>)supplementaryViewDataSource; // force cast

        let config = [[CKTransactionalComponentDataSourceConfiguration alloc]
                      initWithComponentProvider:castedComponentProviderClass
                      context:context
                      sizeRange:CKSizeRange(minSize, maxSize)];

        _innerDatasource =
        [[CKCollectionViewTransactionalDataSource alloc]
         initWithCollectionView:collectionView
         supplementaryViewDataSource:castedSupplementary
         configuration:config];
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
@end
