//
//  CKChangeSetWrapper.h
//  Pods
//
//  Created by Gao on 10/13/16.
//
//

#import <Foundation/Foundation.h>

/**
 Designated initializer. Any parameter may be nil.
 @param updatedItems Mapping from NSIndexPath to updated model.
 @param removedItems Set of NSIndexPath.
 @param removedSections NSIndexSet of section indices.
 @param movedItems Mapping from NSIndexPath to NSIndexPath.
 @param insertedSections NSIndexSet of section indices.
 @param insertedItems Mapping from NSIndexPath to new model.
 */
@interface CKChangeSetWrapper : NSObject<NSCopying>

@property (nonatomic, copy, nullable) NSDictionary<NSIndexPath *, id<NSObject>> *updatedItems;
@property (nonatomic, copy, nullable) NSSet<NSIndexPath *> *removedItems;
@property (nonatomic, copy, nullable) NSIndexSet *removedSections;
@property (nonatomic, copy, nullable) NSDictionary *movedItems;
@property (nonatomic, copy, nullable) NSIndexSet *insertedSections;
@property (nonatomic, copy, nullable) NSDictionary<NSIndexPath *, id<NSObject>> *insertedItems;
@property (nonatomic, copy, nullable) NSDictionary *userInfo;


@end
