//
//  CSStaticLayoutComponent.h
//  Pods
//
//  Created by Gao on 03/06/2017.
//
//

#import "CSComponent.h"

/// fot CKStaticLayoutComponentChild
NS_SWIFT_NAME(StaticLayoutChild)
@interface CSStaticLayoutChild: CSOptionBase

@property (nonatomic) CGPoint position;
@property (nonatomic, nullable) CSComponent *component;

/**
 If specified, the component's size is restricted according to this size. Percentages are resolved relative to the
 static layout component.

 The default is Auto in both dimensions, which sets the child's min size to zero and max size to the maximum available
 space it can consume without overflowing the component's bounds.
 
 If you set width/heigth in size, the min/max-width/heigth is disabled.
 */
@property (nonatomic, nullable) CSSize *size;
@end

/*
 A component that positions children at fixed positions.

 Computes a size that is the union of all childrens' frames.
 
 for CKStaticLayoutComponent
 */
NS_SWIFT_NAME(StaticLayoutComponent)
@interface CSStaticLayoutComponent: CSComponent

- (nonnull instancetype)initWithView:(nullable CSViewConfiguration *)view
                                size:(nullable CSSize *)size
                            children:(nonnull NSArray<CSStaticLayoutChild *> *)children NS_REFINED_FOR_SWIFT;

@end

