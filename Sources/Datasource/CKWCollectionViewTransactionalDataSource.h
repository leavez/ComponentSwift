//
//  CKWCollectionViewTransactionalDataSource.h
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

#import <UIKit/UIKit.h>
#import "CKWComponentProvider.h"
#import "CKWChangeSet.h"
NS_SWIFT_NAME(SupplementaryViewDataSource)
@protocol CKWSupplementaryViewDataSource;


NS_ASSUME_NONNULL_BEGIN

/// for CKCollectionViewTransactionalDataSource
NS_SWIFT_NAME(CSCollectionViewDataSource)
@interface CKWCollectionViewTransactionalDataSource : NSObject

@property (readonly, nonatomic) UICollectionView *collectionView;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithCollectionView:(UICollectionView *)collectionView
           supplementaryViewDataSource:(nullable id<CKWSupplementaryViewDataSource>)supplementaryViewDataSource
                     componentProvider:(Class<CKWComponentProviderProtocol>)componentProvider
                               context:(nullable id)context
                               minSize:(CGSize)minSize
                               maxSize:(CGSize)maxSize NS_REFINED_FOR_SWIFT;


/**
 Applies a changeset either synchronously or asynchronously to the collection view.
 If a synchronous changeset is applied while asynchronous changesets are still pending, then the pending changesets will be applied synchronously
 before the new changeset is applied.
 */
- (void)applyChangeset:(CKWChangeSet *)changeset
        asynchronously:(BOOL)asynchronously
              userInfo:(nullable NSDictionary *)userInfo NS_REFINED_FOR_SWIFT;

/**
 @return The model associated with a certain index path in the collectionView.

 As stated above components are generated asynchronously and on a backgorund thread. This means that a changeset is enqueued
 and applied asynchronously when the corresponding component tree is generated. For this reason always use this method when you
 want to retrieve the model associated to a certain index path in the table view (e.g in didSelectRowAtIndexPath: )
 */
- (nullable id<NSObject>)modelForItemAtIndexPath:(nullable NSIndexPath *)indexPath;

/**
 @return The layout size of the component tree at a certain indexPath. Use this to access the component sizes for instance in a
 `UICollectionViewLayout(s)` or in a `UICollectionViewDelegateFlowLayout`.
 */
- (CGSize)sizeForItemAtIndexPath:(NSIndexPath *)indexPath;

/** @see `CKTransactionalComponentDataSource` */
- (void)reloadAsynchronously:(BOOL)asynchronously
                    userInfo:(nullable NSDictionary *)userInfo;


@end




NS_SWIFT_NAME(SupplementaryViewDataSource)
@protocol CKWSupplementaryViewDataSource<NSObject>

- (nullable UICollectionReusableView *)collectionView:(UICollectionView *)collectionView
                    viewForSupplementaryElementOfKind:(NSString *)kind
                                          atIndexPath:(NSIndexPath *)indexPath;
@end


NS_ASSUME_NONNULL_END
