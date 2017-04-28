//
//  CKWTextAttributes.m
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

#import "CKWTextAttributes.h"
#import "CKWViewAttribute+Inner.h"

@implementation CKWTextAttributes

- (CKTextKitAttributes)convert {
    return {
        .attributedString = self.attributedString,
        .truncationAttributedString = self.truncationAttributedString,
        .avoidTailTruncationSet = self.avoidTailTruncationSet,
        .lineBreakMode = self.lineBreakMode,
        .maximumNumberOfLines = self.maximumNumberOfLines,
        .shadowOffset = self.shadowOffset,
        .shadowColor = self.shadowColor,
        .shadowOpacity = self.shadowOpacity,
        .shadowRadius = self.shadowRadius,
        .layoutManagerFactory = self.layoutManagerFactory,
    };
}

@end
