//
//  CSComposeComponent+DynamicClass.m
//  Pods
//
//  Created by Gao on 13/05/2017.
//
//

#import "CSCompositeComponent+DynamicClass.h"
#import <ComponentKit/CKComponentSubclass.h>
#import "macro.h"
#import "CppHeaders.h"
#import "CKComponent+Injected.h"

static NSString *const prefix = @"CSDynamicSubclass_";

Class createSubclassDynamically(Class nameClass, Class targetSuperClass) {

    NSCAssert(nameClass != nil, @"class shouldn't be nil");
    NSString *subclassName = [prefix stringByAppendingString:NSStringFromClass(nameClass)];
    Class subclass = NSClassFromString(subclassName);

    if (!subclass) {
        subclass = objc_allocateClassPair(targetSuperClass, [subclassName UTF8String], 0);
        objc_registerClassPair(subclass);
    }
    return subclass;
}



@implementation CKForwarderComponent
@end

@implementation CKAnimationForwarderComponnent

- (std::vector<CKComponentAnimation>)ckanimationFromAnimation:(NSArray<CSComponentAnimation *> *)animations {
    std::vector<CKComponentAnimation> anis = {};
    for (CSComponentAnimation *c in animations) {
        let converted = c.convert;
        anis.push_back(converted);
    }
    return anis;
}

- (std::vector<CKComponentAnimation>)animationsOnInitialMount {
    if (![self.target respondsToSelector:@selector(animationsOnInitialMount)]) {
        return {};
    }
    let animations = [self.target animationsOnInitialMount];
    return [self ckanimationFromAnimation:animations];
}

- (std::vector<CKComponentAnimation>)animationsFromPreviousComponent:(CKComponent *)previousComponent {
    if (![self.target respondsToSelector:@selector(animationsFromPreviousComponent:)]) {
        return {};
    }
    let animations = [self.target animationsFromPreviousComponent:previousComponent.wrapper];
    return [self ckanimationFromAnimation:animations];
}


//- (CKComponentBoundsAnimation)boundsAnimationFromPreviousComponent:(CKComponent *)previousComponent
//{
//    return {};
//}
@end

