//
//  CSTextComponent.h
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

#import "CSComponent.h"
#import "CSTextAttributes.h"
#import "CSViewAttributes.h"


typedef NS_ENUM(NSUInteger, CSAsyncLayerDisplayMode) {
    /** Crawls up superlayers. If an async transaction container layer is found, renders async; otherwise, sync. */
    CSAsyncLayerDisplayModeDefault,
    /** Always renders async, even if no parent async transaction container layer is found. */
    CSAsyncLayerDisplayModeAlwaysAsync,
    /** Always render synchronously. This skips crawling superlayers to find a container, which may improve perf. */
    CSAsyncLayerDisplayModeAlwaysSync,
};

// for CKTextComponentOptions
NS_SWIFT_NAME(TextComponentOptions)
@interface CSTextComponentOptions : CSOptionBase
/**
 Controls if rendering should be done synchronously or async
 See @CKAsyncLayer
 */
@property (nonatomic) CSAsyncLayerDisplayMode displayMode;

@property (nonatomic, nullable) NSNumber *isAccessibilityElement;
@property (nonatomic, nullable) NSNumber *providesAccessibleElements;
/**
 Should rarely be used, the component's text will be used by default.
 */
@property (nonatomic, nullable) CSAccessibilityTextAttribute *accessibilityLabel;
@end

// for CKTextComponent
NS_SWIFT_NAME(TextComponent)
@interface CSTextComponent : CSComponent

- (nonnull instancetype)initWithTextAttributes:(nonnull CSTextAttributes *)attributes
                                viewAttributes:(nullable CSViewAttributeMap *)viewAttributes
                                       options:(nullable CSTextComponentOptions *)options
                                          size:(nullable CSSize *)size NS_REFINED_FOR_SWIFT;

@end





