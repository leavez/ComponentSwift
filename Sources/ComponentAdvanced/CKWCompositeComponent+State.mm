//
//  CKWCompositeComponent+State.m
//  Pods
//
//  Created by Gao on 12/05/2017.
//
//

#import "CKWCompositeComponent+State.h"
#import "CppHeaders.h"
#import <ComponentKit/CKComponentSubclass.h>

@implementation CKWCompositeComponent (State)

- (void)updateState:(id (^)(id))updateBlock asynchronously:(BOOL)asynchronously {
    [self.realComponentWithoutChangingOwnership updateState:updateBlock mode:asynchronously ? CKUpdateModeAsynchronous : CKUpdateModeSynchronous];
}

@end
