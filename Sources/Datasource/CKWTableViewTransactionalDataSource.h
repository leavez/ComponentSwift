//
//  CKWTableViewTransactionalDataSource.h
//  Pods
//
//  Created by Gao on 16/05/2017.
//
//

#import <UIKit/UIKit.h>
#import "CKWComponentProvider.h"
#import "CKWChangeSet.h"
NS_SWIFT_NAME(TableViewSupplementaryDataSource)
@protocol CKWTableViewSupplementaryDataSource;
@class CKWTableViewCellConfiguration;

NS_ASSUME_NONNULL_BEGIN
NS_SWIFT_NAME(CSTableViewDataSource)
@interface CKWTableViewTransactionalDataSource : NSObject

@property (readonly, nonatomic) UITableView *tableView;

- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithTableView:(UITableView *)tableView
      supplementaryViewDataSource:(nullable id<CKWTableViewSupplementaryDataSource>)supplementaryViewDataSource
                componentProvider:(Class<CKWComponentProviderProtocol>)componentProvider
                          context:(nullable id)context
                cellConfiguration:(CKWTableViewCellConfiguration *)cellConfiguration
                          minSize:(CGSize)minSize
                          maxSize:(CGSize)maxSize NS_REFINED_FOR_SWIFT;


/**
 Applies a changeset either synchronously or asynchronously to the collection view.
 If a synchronous changeset is applied while asynchronous changesets are still pending, then the pending changesets will be applied synchronously
 before the new changeset is applied.
 */
- (void)applyChangeset:(CKWChangeSet *)changeset
        asynchronously:(BOOL)asynchronously
     cellConfiguration:(nullable CKWTableViewCellConfiguration *)cellConfiguration NS_REFINED_FOR_SWIFT;



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





/**
 *	A function that can be used to customize the cell's appearance.
 *  @param cell The UITableViewCell to be displayed
 *  @param indexPath The indexPath for the cell
 *  @param model The cell's model.
 *  @note This is be used very conservatively since this could quite easily
 *  cause unwanted side-effects with cell reuse, since no attempts are made
 *  to undo settings applied here.
 */
typedef void(*CKWTableViewCellConfigurationFunction)(UITableViewCell *cell, NSIndexPath *indexPath, id<NSObject> model);


/**
 Configuration value object that wraps most that should be necessary to customize
 the cell's "out of the box" features.

 @note Properties are mutable for convenience when instantiating. However,
 CKTableViewTransactionalDataSource always returns a copy from its -cellConfiguration
 property. Mutate the copy and pass it in an update operation to override the default.
 */
NS_SWIFT_NAME(TableViewCellConfiguration)
@interface CKWTableViewCellConfiguration : NSObject

@property (nonatomic, assign) UITableViewRowAnimation animationRowInsert;
@property (nonatomic, assign) UITableViewRowAnimation animationRowDelete;
@property (nonatomic, assign) UITableViewRowAnimation animationSectionInsert;
@property (nonatomic, assign) UITableViewRowAnimation animationSectionDelete;
/** If `YES`, will perform updates with `+[UIView performWithoutAnimation:]` */
@property (nonatomic, assign) BOOL animationsDisabled;
@property (nonatomic, assign) CKWTableViewCellConfigurationFunction cellConfigurationFunction;

+ (instancetype)noAnimationConfig;

@end

NS_SWIFT_NAME(TableViewSupplementaryDataSource)
@protocol CKWTableViewSupplementaryDataSource <NSObject>
@optional
- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;
- (nullable NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section;
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath;
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath;
- (nullable NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView;
- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index;
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath;
@end




NS_ASSUME_NONNULL_END
