//
//  CKWChangeSet.h
//  Pods
//
//  Created by Gao on 10/13/16.
//
//

#import <Foundation/Foundation.h>

/**
 Designated initializer. Any parameter may be nil.
 */
NS_SWIFT_NAME(ChangeSet)
@interface CKWChangeSet<__covariant ModelType> : NSObject<NSCopying>

@property (nonatomic, copy, nullable) NSDictionary<NSIndexPath *, ModelType> *updatedItems;
@property (nonatomic, copy, nullable) NSSet<NSIndexPath *> *removedItems;
@property (nonatomic, copy, nullable) NSIndexSet *removedSections;
@property (nonatomic, copy, nullable) NSDictionary<NSIndexPath *, NSIndexPath *> *movedItems;
@property (nonatomic, copy, nullable) NSIndexSet *insertedSections;
@property (nonatomic, copy, nullable) NSDictionary<NSIndexPath *, ModelType> *insertedItems;
@property (nonatomic, copy, nullable) NSDictionary *userInfo;

@end
