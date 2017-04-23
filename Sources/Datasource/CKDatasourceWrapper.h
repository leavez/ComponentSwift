//
//  ZHCKDatasourceWrapper.h
//  Pods
//
//  Created by Gao on 10/13/16.
//
//

#import <Foundation/Foundation.h>
#import "CKChangeSetWrapper.h"

typedef void(*CKTableViewCellConfigFunction)( UITableViewCell * _Nonnull cell,  NSIndexPath * _Nonnull indexPath, __nullable id<NSObject> model);

/// a copy of CKComponentProvider
@protocol FakeCKComponentProvider <NSObject>
/// 应该返回一个 CKComponent 类型，但是正是 objc++ 的类，所以不能在这里引用
+ (nullable id)componentWrapperForModel:(nonnull id<NSObject>)model context:(nullable id<NSObject>)context;
@end
@protocol FakeCKTableViewSupplementaryDataSource;


@interface CKDatasourceWrapper : NSObject <FakeCKComponentProvider>


/*
 componentProvider 如果为 nil，则把 self 设为 ComponentProvider。可以重写 componentForModel 方法。
 */
- (nonnull instancetype)initWithTableView:(nonnull UITableView *)tableView
                                    width:(CGFloat)width
                        componentProvider:(nullable Class<FakeCKComponentProvider>)componentProvider
                               cellConfig:(nullable CKTableViewCellConfigFunction)cellConfig
                                  context:(nullable id<NSObject>)context
                  supplementaryDataSource:(nullable NSObject<FakeCKTableViewSupplementaryDataSource> *)supplementaryDataSource;

- (nonnull instancetype)init NS_UNAVAILABLE;


- (CGSize)sizeForItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

/// NOTE： 这个方法在 async apply changeset 的时候，会出现数据不一致的问题。 只能在全部都是 sync 的时候使用
- (NSInteger)numberOfSections;
/// NOTE： 这个方法在 async apply changeset 的时候，会出现数据不一致的问题。 只能在全部都是 sync 的时候使用
- (NSInteger)numberOfObjectsInSection:(NSInteger)section;

/// NOTE： 这个方法在 async apply changeset 的时候，会出现数据不一致的问题。 只能在全部都是 sync 的时候使用
- (nullable NSIndexPath *)indexPathForModel:(nonnull id)model;

// model 相等用指针相等判断
- (nullable id<NSObject>)modelForItemAtIndexPath:(nonnull NSIndexPath *)indexPath;

/// NOTE： 这个方法在 async apply changeset 的时候，会出现数据不一致的问题。 只能在全部都是 sync 的时候使用
- (void)enumerateObjectsUsingBlock:(void(^_Nonnull)(id _Nullable model, NSIndexPath * _Nonnull indexPath, BOOL *_Nullable stop))block;
/// NOTE： 这个方法在 async apply changeset 的时候，会出现数据不一致的问题。 只能在全部都是 sync 的时候使用
- (void)enumerateObjectsInSectionAtIndex:(NSInteger)section usingBlock:(void(^_Nonnull)(id _Nullable model, NSIndexPath *_Nonnull indexPath, BOOL *_Nullable stop))block;


#pragma mark - reload methods

/// 可以用来临时存放一个 changeset，然后更改 changeset，最后使用 commitChange 来应用它
@property (nonatomic, copy, nullable) CKChangeSetWrapper *stagedChangeset;
/// call before using stagedChangeset. This simplely new a stagedChangeset instance.
- (void)prepareChangeset;
/// apply stagedChangeset, and set it to nil.
- (void)commitChangeset:(BOOL)asynchronized;


/// 更改 tableView datasource 内容的方法
- (void)applyChangeset:(nonnull CKChangeSetWrapper *)changeset asynchronized:(BOOL)asynchronized;

/// insert section of 0
- (void)insertFirstSection;

/// 试用于一个 section 的时候
- (void)reloadToObjects:(nonnull NSArray *)objects oldObjects:(nullable NSArray *)oldObjects asynchronized:(BOOL)asynchronized;


/// remove all data, and load updates in `Set`
/// NOTE： 这个方法在 async apply changeset 的时候，会出现数据不一致的问题。 只能在全部都是 sync 的时候使用
- (void)reloadDataToSet:(nonnull CKChangeSetWrapper *)set asynchronized:(BOOL)asynchronized;
/// NOTE： 这个方法在 async apply changeset 的时候，会出现数据不一致的问题。 只能在全部都是 sync 的时候使用
- (void)reloadToObjects:(nonnull NSArray *)objects asynchronized:(BOOL)asynchronized;

/// 重新生成所有 cell。用于夜间模式刷新等用途
- (void)refreshCells:(BOOL)asnychronized;
- (void)updateWidthForConfigIfNeeded:(CGFloat)width;
@end










NS_ASSUME_NONNULL_BEGIN
/// a copy of CKTableViewSupplementaryDataSource
@protocol FakeCKTableViewSupplementaryDataSource <NSObject>
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
