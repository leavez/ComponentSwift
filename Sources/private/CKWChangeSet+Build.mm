//
//  CKWChangeSet+Build.m
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

#import "CKWChangeSet+Build.h"

@implementation CKWChangeSet(build)
- (CKTransactionalComponentDataSourceChangeset *)build {
    return [[CKTransactionalComponentDataSourceChangeset alloc]
            initWithUpdatedItems:self.updatedItems
            removedItems:self.removedItems
            removedSections:self.removedSections
            movedItems:self.movedItems
            insertedSections:self.insertedSections
            insertedItems:self.insertedItems];
}
@end
