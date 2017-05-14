//
//  CKWComposeComponent+DynamicClass.h
//  Pods
//
//  Created by Gao on 13/05/2017.
//
//

#import "CKWCompositeComponent.h"
#import <objc/runtime.h>
#import <ComponentKit/ComponentKit.h>
#import "CKWComponentAnimation.h"

/// Dynamic create an class.
/// This class will inherit `targetSuperClass` and have a name of `nameClass` with a prefix.
Class createSubclassDynamically(Class nameClass, Class targetSuperClass);


@interface CKForwarderComponent : CKCompositeComponent
@property (nonatomic, weak) CKWComponent<CKWComponentAnimationProtocol> *target;
@end

@interface CKAnimationForwarderComponnent : CKForwarderComponent

- (std::vector<CKComponentAnimation>)animationsOnInitialMount;
- (std::vector<CKComponentAnimation>)animationsFromPreviousComponent:(CKComponent *)previousComponent;
@end
