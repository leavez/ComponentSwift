//
//  CSButtonComponent.m
//  Pods
//
//  Created by Gao on 05/05/2017.
//
//

#import "CSButtonComponent.h"
#import <ComponentKit/ComponentKit.h>
#import "CppHeaders.h"
#import "macro.h"


@implementation CSButtonAttributes
@end

@implementation CSButtonComponent

- (instancetype)initWithButtonAttribute:(NSArray<CSButtonAttributes *> *)buttonAttributes titleFont:(UIFont *)titleFont selected:(BOOL)selected enabled:(BOOL)enabled action:(SEL)action size:(CSSize *)size attributes:(CSViewAttributeMap *)attributes accessibilityLabel:(NSString *)accessibilityLabel
{
    self = [super init];
    if (self) {

        std::unordered_map<UIControlState, NSString *> titles = {};
        std::unordered_map<UIControlState, UIColor *> titleColors = {};
        std::unordered_map<UIControlState, UIImage *> images = {};
        std::unordered_map<UIControlState, UIImage *> backgourndImages = {};

        for (CSButtonAttributes *b in buttonAttributes) {
            if (b.title) {
                titles[b.state] = b.title;
            }
            if (b.titleColor) {
                titleColors[b.state] = b.titleColor;
            }
            if (b.image) {
                images[b.state] = b.image;
            }
            if (b.backgroundImage) {
                backgourndImages[b.state] = b.backgroundImage;
            }
        }

        self.realComponent =
        [CKButtonComponent
         newWithTitles:titles
         titleColors:titleColors
         images:images backgroundImages:backgourndImages
         titleFont:titleFont selected:selected
         enabled:enabled action:action
         size:ConvertWithDefault(size, CKComponentSize())
         attributes:ConvertWithDefault(attributes, CKViewComponentAttributeValueMap())
         accessibilityConfiguration:{ .accessibilityLabel = accessibilityLabel }];

    }
    return self;
}

@end
