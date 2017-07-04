//
//  CSComponentInner.m
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import <Foundation/Foundation.h>
#import <ComponentKit/ComponentKit.h>
#import "CSComponent.h"

@interface CSComponent()
/**
 Reference the real ckcomponent.

 When a CSComponent(wrapper) is created, it will create an ckComponent(inner component)
 and retain it. 
 
     wrapper --> inner component
 
 Once `realComponent` is accessed, it will pass the ownership to inner component -- inner
 component retain the wrapper, wrapper weak reference the inner component
 
     wrapper <-- inner component
 
 This will happen when passing CSComponent to parent CSComponent for compositing, or
 when passing CSComponent to datasource.
 */
@property (nonatomic) CKComponent *realComponent;


/// do not use it if you don't konw about it
@property (nonatomic, readonly) CKComponent *realComponentWithoutChangingOwnership;

@end
