//
//  CKWCompositeComponent+State.h
//  Pods
//
//  Created by Gao on 12/05/2017.
//
//

#import "CKWCompositeComponent.h"

@interface CKWCompositeComponent (State)

- (void)updateState:(id _Nullable (^_Nonnull)(id _Nullable))updateBlock asynchronously:(BOOL)asynchronously NS_REFINED_FOR_SWIFT;

@end
