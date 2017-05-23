//
//  CSTextComponent.m
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

#import "CSTextComponent.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"

@implementation CSTextComponentOptions

- (CKTextComponentOptions)convert {
    return {
        .displayMode = (CKAsyncLayerDisplayMode)self.displayMode,
        .accessibilityContext = {
            .isAccessibilityElement = self.isAccessibilityElement,
            .providesAccessibleElements = self.providesAccessibleElements,
            .accessibilityLabel = self.accessibilityLabel.convert,
        }
    };
}

@end

@implementation CSTextComponent

- (instancetype)initWithTextAttributes:(CSTextAttributes *)attributes
                        viewAttributes:(CSViewAttributeMap *)viewAttributes
                               options:(CSTextComponentOptions *)options
                                  size:(CSSize *)size {
    self = [super init];
    if (self) {
        
        CKViewComponentAttributeValueMap attrs;
        if (viewAttributes) {
            attrs = viewAttributes.convert;
        } else {
            attrs = {};
        }

        self.realComponent =
        [CKTextComponent newWithTextAttributes:attributes.convert
                                viewAttributes:attrs
                                       options:options.convert
                                          size:size.convert];
    }
    return self;
}

@end



