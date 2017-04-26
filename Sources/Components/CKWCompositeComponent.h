//
//  CKWCompositeComponent.h
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import <Foundation/Foundation.h>
#import "CKWComponent.h"
@class CKComponent;

NS_SWIFT_NAME(CompositeComponent)
@interface CKWCompositeComponent : CKWComponent

- (nullable instancetype)initWithComponent:(nullable CKWComponent *)component;

- (nullable instancetype)initWithCKComponent:(nullable CKComponent *)component;

@end
