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

NS_SWIFT_NAME(Component)
@interface CKWComponent : NSObject

- (nonnull instancetype)initWithView:(nonnull CKWViewConfiguration *)view
                                size:(nullable CKWSize *)size;

- (nullable id)nextResponder;

@end

