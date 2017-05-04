//
//  CKWTextAttributes.h
//  Pods
//
//  Created by Gao on 28/04/2017.
//
//

#import "CKWCreatorBase.h"

/// for CKTextKitAttributes
@interface CKWTextAttributes : CKWCreatorBase
/**
 The string to be drawn.  CKTextKit will not augment this string with default colors, etc. so this must be complete.
 */
@property (nonatomic, copy, nullable) NSAttributedString *attributedString;
/**
 The string to use as the truncation string, usually just "...".  If you have a range of text you would like to
 restrict highlighting to (for instance if you have "... Continue Reading", use the CKTextKitTruncationAttributeName
 to mark the specific range of the string that should be highlightable.
 */
@property (nonatomic, copy, nullable) NSAttributedString *truncationAttributedString;
/**
 This is the character set that CKTextKit should attempt to avoid leaving as a trailing character before your
 truncation token.  By default this set includes "\s\t\n\r.,!?:;" so you don't end up with ugly looking truncation
 text like "Hey, this is some fancy Truncation!\n\n...".  Instead it would be truncated as "Hey, this is some fancy
 truncation...".  This is not always possible.

 Set this to the empty charset if you want to just use the "dumb" truncation behavior.  A nil value will be
 substituted with the default described above.
 */
@property (nonatomic, copy, nullable) NSCharacterSet *avoidTailTruncationSet;
/**
 The line-break mode to apply to the text.  Since this also impacts how TextKit will attempt to truncate the text
 in your string, we only support NSLineBreakByWordWrapping and NSLineBreakByCharWrapping.
 */
@property (nonatomic) NSLineBreakMode lineBreakMode;
/**
 The maximum number of lines to draw in the drawable region.  Leave blank or set to 0 to define no maximum.
 */
@property (nonatomic) NSInteger maximumNumberOfLines;
/**
 The shadow offset for any shadows applied to the text.  The coordinate space for this is the same as UIKit, so a
 positive width means towards the right, and a positive height means towards the bottom.
 */
@property (nonatomic) CGSize shadowOffset;
/**
 The color to use in drawing the text's shadow.
 */
@property (nonatomic, nullable) UIColor *shadowColor;
/**
 The opacity of the shadow from 0 to 1.
 */
@property (nonatomic) CGFloat shadowOpacity;
/**
 The radius that should be applied to the shadow blur.  Larger values mean a larger, more blurred shadow.
 */
@property (nonatomic) CGFloat shadowRadius;
/**
 A pointer to a function that that returns a custom layout manager subclass. If nil, defaults to NSLayoutManager.
 */
@property (nonatomic, nullable) NSLayoutManager *(*layoutManagerFactory)(void);

@end

