//
//  CSStackLayoutComponent.h
//  Pods
//
//  Created by Gao on 04/05/2017.
//
//

#import "CSComponent.h"


typedef NS_ENUM(NSUInteger, CSStackLayoutDirection) {
    CSStackLayoutDirectionVertical,
    CSStackLayoutDirectionHorizontal,
} NS_SWIFT_NAME(StackLayoutDirection);

/** If no children are flexible, how should this component justify its children in the available space? */
typedef NS_ENUM(NSUInteger, CSStackLayoutJustifyContent) {
    /**
     On overflow, children overflow out of this component's bounds on the right/bottom side.
     On underflow, children are left/top-aligned within this component's bounds.
     */
    CSStackLayoutJustifyContentStart,
    /**
     On overflow, children are centered and overflow on both sides.
     On underflow, children are centered within this component's bounds in the stacking direction.
     */
    CSStackLayoutJustifyContentCenter,
    /**
     On overflow, children overflow out of this component's bounds on the left/top side.
     On underflow, children are right/bottom-aligned within this component's bounds.
     */
    CSStackLayoutJustifyContentEnd,
} NS_SWIFT_NAME(StackLayoutJustifyContent);

typedef NS_ENUM(NSUInteger, CSStackLayoutAlignItems) {
    /** Align children to start of cross axis */
    CSStackLayoutAlignItemsStart,
    /** Align children with end of cross axis */
    CSStackLayoutAlignItemsEnd,
    /** Center children on cross axis */
    CSStackLayoutAlignItemsCenter,
    /** Expand children to fill cross axis */
    CSStackLayoutAlignItemsStretch,
} NS_SWIFT_NAME(StackLayoutAlignItems);

/**
 Each child may override their parent stack's cross axis alignment.
 @see CSStackLayoutAlignItems
 */
typedef NS_ENUM(NSUInteger, CSStackLayoutAlignSelf) {
    /** Inherit alignment value from containing stack. */
    CSStackLayoutAlignSelfAuto,
    CSStackLayoutAlignSelfStart,
    CSStackLayoutAlignSelfEnd,
    CSStackLayoutAlignSelfCenter,
    CSStackLayoutAlignSelfStretch,
} NS_SWIFT_NAME(StackLayoutAlignSelf);

/// for CKStackLayoutComponentStyle.
NS_SWIFT_NAME(StackLayoutStyle)
@interface CSStackLayoutStyle : CSCreatorBase

/** Specifies the direction children are stacked in. */
@property (nonatomic) CSStackLayoutDirection direction;
/** The amount of space between each child. */
@property (nonatomic) CGFloat spacing;
/** How children are aligned if there are no flexible children. */
@property (nonatomic) CSStackLayoutJustifyContent justifyContent;
/** Orientation of children along cross axis */
@property (nonatomic) CSStackLayoutAlignItems alignItems;

@end


/// for CKStackLayoutComponentChild.
NS_SWIFT_NAME(StackLayoutChild)
@interface CSStackLayoutChild : CSCreatorBase

@property (nonatomic, nullable) CSComponent *component;
/** Additional space to place before the component in the stacking direction. */
@property (nonatomic) CGFloat spacingBefore;
/** Additional space to place after the component in the stacking direction. */
@property (nonatomic) CGFloat spacingAfter;
/** If the sum of childrens' stack dimensions is less than the minimum size, should this component grow? */
@property (nonatomic) BOOL flexGrow;
/** If the sum of childrens' stack dimensions is greater than the maximum size, should this component shrink? */
@property (nonatomic) BOOL flexShrink;
/** Specifies the initial size in the stack dimension for the child. */
@property (nonatomic, nullable) CSDimension *flexBasis;
/** Orientation of the child along cross axis, overriding alignItems */
@property (nonatomic) CSStackLayoutAlignSelf alignSelf;

@end



NS_SWIFT_NAME(StackLayoutComponent)
@interface CSStackLayoutComponent : CSComponent


- (nonnull instancetype)initWithView:(nullable CSViewConfiguration *)view
                        size:(nullable CSSize *)size
                       style:(nullable CSStackLayoutStyle *)style
                    children:(nonnull NSArray<CSStackLayoutChild *> *)children NS_REFINED_FOR_SWIFT;

- (nonnull instancetype)initWithView:(nullable CSViewConfiguration *)view
                                size:(nullable CSSize *)size NS_UNAVAILABLE;

@end
