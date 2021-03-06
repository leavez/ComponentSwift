//
//  CSChangeSet.h
//  Pods
//
//  Created by Gao on 10/13/16.
//
//

#import <Foundation/Foundation.h>

// for CKTransactionalComponentDataSourceChangeset
NS_SWIFT_NAME(ChangeSet)
@interface CSChangeSet : NSObject<NSCopying>

@property (nonatomic, copy, nullable) NSDictionary<NSIndexPath *, id> *updatedItems;
@property (nonatomic, copy, nullable) NSSet<NSIndexPath *> *removedItems;
@property (nonatomic, copy, nullable) NSIndexSet *removedSections;
@property (nonatomic, copy, nullable) NSDictionary<NSIndexPath *, NSIndexPath *> *movedItems;
@property (nonatomic, copy, nullable) NSIndexSet *insertedSections;
@property (nonatomic, copy, nullable) NSDictionary<NSIndexPath *, id> *insertedItems;
@property (nonatomic, copy, nullable) NSDictionary *userInfo;

@end
