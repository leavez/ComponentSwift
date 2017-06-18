//
//  CSStaticLayoutComponent.m
//  Pods
//
//  Created by Gao on 03/06/2017.
//
//

#import "CSStaticLayoutComponent.h"
#import "CppHeaders.h"
#import "macro.h"

@implementation CSStaticLayoutChild

- (CKStaticLayoutComponentChild)convert {

    let a = CKRelativeDimension::Auto();
    var sizeRange = CKRelativeSizeRange( {
        ConvertWithDefault(self.size.minWidth, a),
        ConvertWithDefault(self.size.minHeight, a)
    }, {
        ConvertWithDefault(self.size.maxWidth, a),
        ConvertWithDefault(self.size.maxHeight, a)
    });

    if (self.size.width) {
        sizeRange.min.width = ConvertWithDefault(self.size.width, a);
        sizeRange.max.width = sizeRange.min.width;
    }
    if (self.size.height) {
        sizeRange.min.height = ConvertWithDefault(self.size.height, a);
        sizeRange.max.height = sizeRange.min.height;
    }

    return {
        .position = self.position,
        .component = self.component.realComponent,
        .size = sizeRange,
    };
}

@end


@implementation CSStaticLayoutComponent

- (instancetype)initWithView:(CSViewConfiguration *)view size:(CSSize *)size children:(NSArray<CSStaticLayoutChild *> *)children {
    self = [super init];
    if (self) {
        std::vector<CKStaticLayoutComponentChild> converted = {};
        for (CSStaticLayoutChild *c in children) {
            converted.push_back(c.convert);
        }

        self.realComponent = [CKStaticLayoutComponent
                              newWithView:ConvertWithDefault(view, CKComponentViewConfiguration())
                              size: ConvertWithDefault(size, CKComponentSize())
                              children:converted];
    }
    return self;
}

@end


