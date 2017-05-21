//
//  CKWCollectionViewDataSource.m
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

#import "CKWCollectionViewDataSource.h"
#import <ComponentKit/ComponentKit.h>
#import "macro.h"
#import "CKWChangeSet+Build.h"


@implementation CKWCollectionViewDataSource {
    CKCollectionViewTransactionalDataSource *_innerDatasource;
}

- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
           supplementaryViewDataSource:(id<CKWSupplementaryViewDataSource>)supplementaryViewDataSource
                     componentProvider:(Class<CKWComponentProviderProtocol>)componentProvider
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

- (void)applyChangeset:(CKWChangeSet *)changeset asynchronously:(BOOL)asynchronously userInfo:(NSDictionary *)userInfo {
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
