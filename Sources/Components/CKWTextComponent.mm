//
//  CKWTextComponent.m
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

#import "CKWTextComponent.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"

@implementation CKWTextComponentOptions

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

@implementation CKWTextComponent

- (instancetype)initWithTextAttributes:(CKWTextAttributes *)attributes
                        viewAttributes:(CKWViewAttributeMap *)viewAttributes
                               options:(CKWTextComponentOptions *)options
                                  size:(CKWSize *)size {
    self = [super init];
    if (self) {
        
        CKViewComponentAttributeValueMap attrs = {};
        if (viewAttributes) {
            attrs = viewAttributes.convert;
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



