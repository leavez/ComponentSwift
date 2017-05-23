//
//  CSStackLayoutComponent.m
//  Pods
//
//  Created by Gao on 04/05/2017.
//
//

#import "CSStackLayoutComponent.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"
#import "macro.h"

@implementation CSStackLayoutStyle
- (CKStackLayoutComponentStyle)convert {
    return {
        .direction = (CKStackLayoutDirection)self.direction,
        .spacing = self.spacing,
        .justifyContent = (CKStackLayoutJustifyContent)self.justifyContent,
        .alignItems = (CKStackLayoutAlignItems)self.alignItems,
    };
}
@end


@implementation CSStackLayoutChild
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


@implementation CSStackLayoutComponent

- (instancetype)initWithView:(CSViewConfiguration *)view size:(CSSize *)size style:(CSStackLayoutStyle *)style children:(NSArray<CSStackLayoutChild *> *)children
{
    self = [super init];
    if (self) {

        std::vector<CKStackLayoutComponentChild> converted = {};
        for (CSStackLayoutChild *c in children) {
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
