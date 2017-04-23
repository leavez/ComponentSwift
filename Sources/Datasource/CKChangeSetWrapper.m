//
//  CKChangeSetWrapper.m
//  Pods
//
//  Created by Gao on 10/13/16.
//
//

#import "CKChangeSetWrapper.h"

@implementation CKChangeSetWrapper
- (instancetype)copyWithZone:(NSZone *)zone {
    CKChangeSetWrapper *new = [CKChangeSetWrapper new];
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
