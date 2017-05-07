//
//  ZHCKDatasourceWrapper.m
//  Pods
//
//  Created by Gao on 10/13/16.
//
//

#import "CKDatasourceWrapper.h"
#import <ComponentKit/ComponentKit.h>
#import <CKToolbox/CKTableViewDatasourceCell.h>
#import <CKToolbox/CKTableViewTransactionalDataSource.h>
#import <CKToolbox/CKTableViewTransactionalDataSourceCellConfiguration.h>
#import <ComponentKit/CKTransactionalComponentDataSourceChangesetInternal.h>
#import <ComponentKit/CKTransactionalComponentDataSourceState.h>
#import <ComponentKit/CKTransactionalComponentDataSourceStateInternal.h>
#import <ComponentKit/CKTransactionalComponentDataSourceItem.h>


#import "CKWComponentInner.h"
#import "CKComponent+Injected.h"
#import "CKWChangeSet+Build.h"

















@interface CKDatasourceWrapper()<CKComponentProvider>
@property (nonatomic) CKTableViewTransactionalDataSource *innerDatasource;

//
@property (nonatomic) Class<CKComponentProvider> componentProviderClass;
@property (nonatomic,weak) id<NSObject> context;
@property (nonatomic) CGFloat width;
@end

@implementation CKDatasourceWrapper

- (instancetype)initWithTableView:(UITableView *)tableView
                            width:(CGFloat)width
                componentProvider:(Class<CKWComponentProviderProtocol, NSObject>)componentProvider
                       cellConfig:(CKWTableViewCellConfigFunction)cellConfig
                          context:(id<NSObject>)context
          supplementaryDataSource:(NSObject<CKWTableViewSupplementaryDataSource> *)supplementaryDataSource
{
    self = [super init];
    if (self) {
        // 这里有 2 个强制转换
        Class<CKComponentProvider> componentProviderClass = (Class<CKComponentProvider>)componentProvider;
        NSObject<CKTableViewSupplementaryDataSource> *supplementary = (NSObject<CKTableViewSupplementaryDataSource> *)supplementaryDataSource;

        _innerDatasource =
        [[CKTableViewTransactionalDataSource alloc]
         initWithTableView:tableView
         supplementaryDataSource:supplementary
         configuration:[self configurationWithComponentProvider:componentProviderClass ?: self.class
                                                          width:width
                                                        context:context]
         defaultCellConfiguration:[self cellConfiguration:cellConfig
                                             rowAnimation:UITableViewRowAnimationNone]
         ];
        
        self.componentProviderClass = componentProviderClass;
        self.context = context;
        self.width = width;
    }
    return self;
}

- (CKTransactionalComponentDataSourceConfiguration *)configurationWithComponentProvider:(Class<CKComponentProvider>)componentProvider width:(CGFloat)width context:(id<NSObject>)context {

    CKComponentFlexibleSizeRangeProvider *provider =
    [CKComponentFlexibleSizeRangeProvider providerWithFlexibility:CKComponentSizeRangeFlexibleHeight];
    CGSize size = CGSizeMake(width, 0);
    CKSizeRange sizeRange = [provider sizeRangeForBoundingSize:size];

    return [[CKTransactionalComponentDataSourceConfiguration alloc]
            initWithComponentProvider:componentProvider
            context:context
            sizeRange:sizeRange];
}

- (CKTableViewTransactionalDataSourceCellConfiguration *)cellConfiguration:(CKWTableViewCellConfigFunction)configFunction rowAnimation:(UITableViewRowAnimation)rowAnimation {

    CKTableViewTransactionalDataSourceCellConfiguration *ckCellConfig = [CKTableViewTransactionalDataSourceCellConfiguration new];
    ckCellConfig.cellConfigurationFunction = configFunction;
    ckCellConfig.animationRowDelete =
    ckCellConfig.animationRowInsert =
    ckCellConfig.animationSectionDelete =
    ckCellConfig.animationSectionInsert = rowAnimation;
    if (rowAnimation == UITableViewRowAnimationNone) {
        ckCellConfig.animationsDisabled = YES;
    }
    return ckCellConfig;
}

#pragma mark - warpper


- (CGSize)sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [self .innerDatasource sizeForItemAtIndexPath:indexPath];
}

- (NSInteger)numberOfSections {
    return [[self currentDatasourceState] numberOfSections];
}

- (NSInteger)numberOfObjectsInSection:(NSInteger)section {
    return [[self currentDatasourceState] numberOfObjectsInSection:section];
}

- (nullable id<NSObject>)modelForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    return [self.innerDatasource modelForItemAtIndexPath:indexPath];
}

- (nullable NSIndexPath *)indexPathForModel:(nonnull id)model {
    if (!model) {
        return nil;
    }
    __block NSIndexPath *index = nil;
    [self enumerateObjectsUsingBlock:^(id m, NSIndexPath *indexPath, BOOL *stop) {
        if (m == model) {
            index = indexPath;
            *stop = YES;
        }
    }];
    return index;
}


- (void)enumerateObjectsUsingBlock:(void(^)(id model, NSIndexPath *indexPath, BOOL *stop))block {
    return [[self currentDatasourceState] enumerateObjectsUsingBlock:^(CKTransactionalComponentDataSourceItem *item, NSIndexPath *index, BOOL *stop) {
        block(item.model, index, stop);
    }];
}

- (void)enumerateObjectsInSectionAtIndex:(NSInteger)section usingBlock:(void(^)(id model, NSIndexPath *indexPath, BOOL *stop))block {
    return [[self currentDatasourceState] enumerateObjectsInSectionAtIndex:section usingBlock:^(CKTransactionalComponentDataSourceItem *item, NSIndexPath *index, BOOL *stop) {
        block(item.model, index, stop);
    }];
}


#pragma mark - reload methods

- (void)prepareChangeset {
    self.stagedChangeset = [CKWChangeSet new];
}
- (void)commitChangeset:(BOOL)asynchronized {
    [self applyChangeset:self.stagedChangeset asynchronized:asynchronized];
    self.stagedChangeset = nil;
}

- (void)applyChangeset:(CKWChangeSet *)changeset asynchronized:(BOOL)asynchronized {
    if (!changeset) {
        return;
    }
    [self.innerDatasource applyChangeset:changeset.build mode:asynchronized ? CKUpdateModeAsynchronous : CKUpdateModeSynchronous cellConfiguration:nil];
}

- (void)insertFirstSection {
    CKWChangeSet *changeSet = [CKWChangeSet new];
    changeSet.insertedSections = [NSIndexSet indexSetWithIndex:0];
    [self applyChangeset:changeSet asynchronized:NO];
}

- (void)reloadToObjects:(nonnull NSArray *)objects oldObjects:(nullable NSArray *)oldObjects asynchronized:(BOOL)asynchronized {
    CKWChangeSet *changeSet = [CKWChangeSet new];
    NSMutableDictionary *inserts = [NSMutableDictionary dictionaryWithCapacity:objects.count];
    for (NSInteger i = 0; i < objects.count; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        inserts[index] = objects[i];
    }
    NSMutableSet *deletions = [NSMutableSet setWithCapacity:oldObjects.count];
    for (NSInteger i = 0; i < oldObjects.count; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        [deletions addObject:index];
    }

    changeSet.removedItems = deletions;
    changeSet.insertedItems = inserts;
    [self applyChangeset:changeSet asynchronized:asynchronized];
}

- (void)reloadDataToSet:(CKWChangeSet *)set asynchronized:(BOOL)asynchronized {
    CKTransactionalComponentDataSourceChangeset *removeAllSet = self.innerDatasource.removeAllChangeset;
    set.removedSections = removeAllSet.removedSections;
    set.removedItems = removeAllSet.removedItems;
    if (!set.insertedSections) {
        set.insertedSections = [NSIndexSet indexSetWithIndex:0];
    }
    [self applyChangeset:set asynchronized:asynchronized];
}


- (void)reloadToObjects:(NSArray *)objects asynchronized:(BOOL)asynchronized {
    CKWChangeSet *changeSet = [CKWChangeSet new];
    NSMutableDictionary *inserts = [NSMutableDictionary dictionaryWithCapacity:objects.count];
    for (NSInteger i = 0; i < objects.count; i++) {
        NSIndexPath *index = [NSIndexPath indexPathForRow:i inSection:0];
        inserts[index] = objects[i];
    }
    changeSet.insertedItems = inserts;
    [self reloadDataToSet:changeSet asynchronized:asynchronized];
}

- (void)refreshCells:(BOOL)asynchronized {
    [self.innerDatasource reloadWithMode:asynchronized ? CKUpdateModeAsynchronous : CKUpdateModeSynchronous userInfo:nil];
}

- (void)updateWidthForConfigIfNeeded:(CGFloat)width {
    if (self.width == width) {
        return;
    }
    [self.innerDatasource updateConfiguration:[self configurationWithComponentProvider:self.componentProviderClass width:width context:self.context] mode:CKUpdateModeSynchronous cellConfiguration:self.innerDatasource.cellConfiguration];
    self.width = width;
}


#pragma mark - inner

- (CKTransactionalComponentDataSourceState *)currentDatasourceState {
    return [self.innerDatasource valueForKey:@"_currentState"];
}


#pragma mark - protocol 

+ (id)componentForModel:(id<NSObject>)model context:(id<NSObject>)context {
    return nil;
}


@end












