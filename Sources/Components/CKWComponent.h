//
//  CKWComponent.h
//  Pods
//
//  Created by Gao on 20/04/2017.
//
//

#import <UIKit/UIKit.h>
#import "CKWViewAttributes.h"


@interface CKWComponent : NSObject

+ (instancetype)newWithView:(CKWViewConfiguration *)view
                       size:(CGSize)size;
- (instancetype)initWithView:(CKWViewConfiguration *)view
                       size:(CGSize)size;

- (id)nextResponder;

@end

