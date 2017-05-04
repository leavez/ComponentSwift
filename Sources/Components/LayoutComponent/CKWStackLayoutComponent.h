//
//  CKWStackLayoutComponent.h
//  Pods
//
//  Created by Gao on 04/05/2017.
//
//

#import "CKWComponent.h"


typedef NS_ENUM(NSUInteger, CKWStackLayoutDirection) {
    CKWStackLayoutDirectionVertical,
    CKWStackLayoutDirectionHorizontal,
};

/** If no children are flexible, how should this component justify its children in the available space? */
typedef NS_ENUM(NSUInteger, CKWStackLayoutJustifyContent) {
    /**
     On overflow, children overflow out of this component's bounds on the right/bottom side.
     On underflow, children are left/top-aligned within this component's bounds.
     */
    CKWStackLayoutJustifyContentStart,
    /**
     On overflow, children are centered and overflow on both sides.
     On underflow, children are centered within this component's bounds in the stacking direction.
     */
    CKWStackLayoutJustifyContentCenter,
    /**
     On overflow, children overflow out of this component's bounds on the left/top side.
     On underflow, children are right/bottom-aligned within this component's bounds.
     */
    CKWStackLayoutJustifyContentEnd,
};

typedef NS_ENUM(NSUInteger, CKWStackLayoutAlignItems) {
    /** Align children to start of cross axis */
    CKWStackLayoutAlignItemsStart,
    /** Align children with end of cross axis */
    CKWStackLayoutAlignItemsEnd,
    /** Center children on cross axis */
    CKWStackLayoutAlignItemsCenter,
    /** Expand children to fill cross axis */
    CKWStackLayoutAlignItemsStretch,
};

/**
 Each child may override their parent stack's cross axis alignment.
 @see CKWStackLayoutAlignItems
 */
typedef NS_ENUM(NSUInteger, CKWStackLayoutAlignSelf) {
    /** Inherit alignment value from containing stack. */
    CKWStackLayoutAlignSelfAuto,
    CKWStackLayoutAlignSelfStart,
    CKWStackLayoutAlignSelfEnd,
    CKWStackLayoutAlignSelfCenter,
    CKWStackLayoutAlignSelfStretch,
};

/// for CKStackLayoutComponentStyle.
@interface CKWStackLayoutStyle : CKWCreatorBase

/** Specifies the direction children are stacked in. */
@property (nonatomic) CKWStackLayoutDirection direction;
/** The amount of space between each child. */
@property (nonatomic) CGFloat spacing;
/** How children are aligned if there are no flexible children. */
@property (nonatomic) CKWStackLayoutJustifyContent justifyContent;
/** Orientation of children along cross axis */
@property (nonatomic) CKWStackLayoutAlignItems alignItems;

@end


/// for CKStackLayoutComponentChild.
@interface CKWStackLayoutChild : CKWCreatorBase

@property (nonatomic, nullable) CKWComponent *component;
/** Additional space to place before the component in the stacking direction. */
@property (nonatomic) CGFloat spacingBefore;
/** Additional space to place after the component in the stacking direction. */
@property (nonatomic) CGFloat spacingAfter;
/** If the sum of childrens' stack dimensions is less than the minimum size, should this component grow? */
@property (nonatomic) BOOL flexGrow;
/** If the sum of childrens' stack dimensions is greater than the maximum size, should this component shrink? */
@property (nonatomic) BOOL flexShrink;
/** Specifies the initial size in the stack dimension for the child. */
@property (nonatomic, nullable) CKWDimension *flexBasis;
/** Orientation of the child along cross axis, overriding alignItems */
@property (nonatomic) CKWStackLayoutAlignSelf alignSelf;

@end



NS_SWIFT_NAME(StackLayoutComponent)
@interface CKWStackLayoutComponent : CKWComponent


- (nonnull instancetype)initWithView:(nullable CKWViewConfiguration *)view
                        size:(nullable CKWSize *)size
                       style:(nullable CKWStackLayoutStyle *)style
                    children:(nonnull NSArray<CKWStackLayoutChild *> *)children NS_REFINED_FOR_SWIFT;

- (nonnull instancetype)initWithView:(nullable CKWViewConfiguration *)view
                                size:(nullable CKWSize *)size NS_UNAVAILABLE;

@end
