//
//  CSComponent.h
//  Pods
//
//  Created by Gao on 20/04/2017.
//
//

#import <UIKit/UIKit.h>
#import "CSViewAttributes.h"
#import "CSSize.h"

NS_SWIFT_NAME(Component)
@interface CSComponent : NSObject

- (nonnull instancetype)initWithView:(nullable CSViewConfiguration *)view
                                size:(nullable CSSize *)size;

- (nullable id)nextResponder;

@end

