//
//  CSChangeSet.m
//  Pods
//
//  Created by Gao on 10/13/16.
//
//

#import "CSChangeSet.h"

@implementation CSChangeSet
- (instancetype)copyWithZone:(NSZone *)zone {
    CSChangeSet *new = [CSChangeSet new];
    new.updatedItems = self.updatedItems;
    new.removedItems = self.removedItems;
    new.removedSections = self.removedSections;
    new.movedItems = self.movedItems;
    new.insertedSections = self.insertedSections;
    new.insertedItems = self.insertedItems;
    new.userInfo = self.userInfo;
    return new;
}
@end
