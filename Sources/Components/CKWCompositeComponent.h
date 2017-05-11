//
//  CKWCompositeComponent.h
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import <Foundation/Foundation.h>
#import "CKWComponent.h"
#import "CKWScope.h"
@class CKComponent;

NS_SWIFT_NAME(CompositeComponent)
@interface CKWCompositeComponent : CKWComponent

- (nullable instancetype)initWithComponent:(nullable CKWComponent *)component;
- (nullable instancetype)initWithView:(nullable CKWViewConfiguration *)view component:(nullable CKWComponent *)component;

- (nullable instancetype)initWithCKComponent:(nullable CKComponent *)component;


#pragma mark - component scope

- (nullable instancetype)initWithScope:(nullable CKWScope *)scope component:(nullable CKWComponent *)component;
- (nullable instancetype)initWithScope:(nullable CKWScope *)scope componentConstructor:(NS_NOESCAPE CKWComponent *_Nullable (^_Nonnull)(id  _Nullable state))component NS_REFINED_FOR_SWIFT;

@end
