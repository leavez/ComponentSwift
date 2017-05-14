//
//  CKWComponentInner.m
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import <Foundation/Foundation.h>
#import <ComponentKit/ComponentKit.h>
#import "CKWComponent.h"

@interface CKWComponent()
/**
 Reference the real ckcomponent.

 When a CKWComponent(wrapper) is created, it will create an ckComponnet(inner component)
 and retain it. 
 
     wrapper --> inner component
 
 Once `realComponent` is accessed, it will pass the ownership to inner component -- inner
 componnet retain the wrapper, wrapper weak reference the inner component
 
     wrapper <-- inner component
 
 This will happen when passing CKWComponent to parent CKWComponent for compositing, or
 when passing CKWComponent to datasource.
 */
@property (nonatomic) CKComponent *realComponent;


/// do not use it if you don't konw about it
@property (nonatomic, readonly) CKComponent *realComponentWithoutChangingOwnership;

@end
