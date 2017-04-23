//
//  CKWComponent.h
//  Pods
//
//  Created by Gao on 20/04/2017.
//
//

#import <UIKit/UIKit.h>
#import "CKWViewAttributes.h"
#import "CKWSize.h"

@interface CKWComponent : NSObject

- (instancetype)initWithView:(CKWViewConfiguration *)view
                       size:(CKWSize *)size;

- (id)nextResponder;

@end

