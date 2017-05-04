//
//  CKWStackLayoutComponent.m
//  Pods
//
//  Created by Gao on 04/05/2017.
//
//

#import "CKWStackLayoutComponent.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"
#import "macro.h"

@implementation CKWStackLayoutStyle
- (CKStackLayoutComponentStyle)convert {
    return {
        .direction = (CKStackLayoutDirection)self.direction,
        .spacing = self.spacing,
        .justifyContent = (CKStackLayoutJustifyContent)self.justifyContent,
        .alignItems = (CKStackLayoutAlignItems)self.alignItems,
    };
}
@end


@implementation CKWStackLayoutChild
- (CKStackLayoutComponentChild)convert {
    return {
        .component = self.component.realComponent,
        .spacingBefore = self.spacingBefore,
        .spacingAfter = self.spacingAfter,
        .flexGrow = self.flexGrow,
        .flexShrink = self.flexShrink,
        .flexBasis = self.flexBasis.convert,
        .alignSelf = (CKStackLayoutAlignSelf)self.alignSelf,
    };
}
@end


@implementation CKWStackLayoutComponent

- (instancetype)initWithView:(CKWViewConfiguration *)view size:(CKWSize *)size style:(CKWStackLayoutStyle *)style children:(NSArray<CKWStackLayoutChild *> *)children
{
    self = [super init];
    if (self) {

        std::vector<CKStackLayoutComponentChild> converted = {};
        for (CKWStackLayoutChild *c in children) {
            converted.push_back(c.convert);
        }

        self.realComponent = [CKStackLayoutComponent
                              newWithView:ConvertWithDefault(view, CKComponentViewConfiguration())
                              size: ConvertWithDefault(size, CKComponentSize())
                              style:ConvertWithDefault(style, CKStackLayoutComponentStyle())
                              children:converted];
    }
    return self;
}

@end
