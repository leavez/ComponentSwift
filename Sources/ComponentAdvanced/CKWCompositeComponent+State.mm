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
    [(self.realComponentStrong ?: self.realComponentWeak) updateState:updateBlock mode:asynchronously ? CKUpdateModeAsynchronous : CKUpdateModeSynchronous];
}

@end
