//
//  CSTextAttributes.m
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

#import "CSTextAttributes.h"
#import "CSObject+Convert.h"

@implementation CSTextAttributes

- (CKTextKitAttributes)convert {
    return {
        .attributedString = self.attributedString,
        .truncationAttributedString = self.truncationAttributedString,
        .avoidTailTruncationSet = self.avoidTailTruncationSet,
        .lineBreakMode = self.lineBreakMode,
        .maximumNumberOfLines = (NSUInteger)MAX(self.maximumNumberOfLines, 0),
        .shadowOffset = self.shadowOffset,
        .shadowColor = self.shadowColor,
        .shadowOpacity = self.shadowOpacity,
        .shadowRadius = self.shadowRadius,
        .layoutManagerFactory = self.layoutManagerFactory,
    };
}

- (BOOL)isEqual:(id)other {
    if (other == self) {
        return YES;
    } else if ([other isKindOfClass:CSTextAttributes.class]){
        return self.convert == ((CSTextAttributes *)other).convert;
    }
    return NO;
}

@end
