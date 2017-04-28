//
//  CKWTextComponent.h
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

#import "CKWComponent.h"
#import "CKWTextAttributes.h"
#import "CKWViewAttributes.h"


typedef NS_ENUM(NSUInteger, CKWAsyncLayerDisplayMode) {
    /** Crawls up superlayers. If an async transaction container layer is found, renders async; otherwise, sync. */
    CKWAsyncLayerDisplayModeDefault,
    /** Always renders async, even if no parent async transaction container layer is found. */
    CKWAsyncLayerDisplayModeAlwaysAsync,
    /** Always render synchronously. This skips crawling superlayers to find a container, which may improve perf. */
    CKWAsyncLayerDisplayModeAlwaysSync,
};

@interface CKWTextComponentOptions : CKWCreatorBase
/**
 Controls if rendering should be done synchronously or async
 See @CKAsyncLayer
 */
@property (nonatomic) CKWAsyncLayerDisplayMode displayMode;

@property (nonatomic, nullable) NSNumber *isAccessibilityElement;
@property (nonatomic, nullable) NSNumber *providesAccessibleElements;
/**
 Should rarely be used, the component's text will be used by default.
 */
@property (nonatomic, nullable) CKWAccessibilityTextAttribute *accessibilityLabel;
@end

NS_SWIFT_NAME(TextComponent)
@interface CKWTextComponent : CKWComponent

- (nonnull instancetype)initWithTextAttributes:(nonnull CKWTextAttributes *)attributes
                                viewAttributes:(nullable CKWViewAttributeMap *)viewAttributes
                                       options:(nullable CKWTextComponentOptions *)options
                                          size:(nullable CKWSize *)size;

@end





