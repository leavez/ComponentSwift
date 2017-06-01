//
//  CSCompositeComponent.h
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import <Foundation/Foundation.h>
#import "CSComponent.h"
#import "CSScope.h"
@class CKComponent;

NS_SWIFT_NAME(__CompositeComponent)
@interface CSCompositeComponent : CSComponent

- (nullable instancetype)initWithComponent:(nullable CSComponent *)component;
- (nullable instancetype)initWithView:(nullable CSViewConfiguration *)view component:(nullable CSComponent *)component;

- (nullable instancetype)initWithCKComponent:(nullable CKComponent *)component;


#pragma mark - component scope

- (nullable instancetype)initWithScope:(nullable CSScope *)scope component:(nullable CSComponent *)component;
- (nullable instancetype)initWithScope:(nullable CSScope *)scope componentConstructor:(NS_NOESCAPE CSComponent *_Nullable (^_Nonnull)(id  _Nullable state))component NS_REFINED_FOR_SWIFT;

@end
