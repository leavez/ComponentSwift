//
//  CSComponent+ViewContext.h
//  Pods
//
//  Created by Gao on 15/06/2017.
//
//

#import <Foundation/Foundation.h>
#import "CSComponent.h"

@interface CSComponent(ViewContext)

/// Get the mounted view of ckcomponent
/// maybe used in the parameter of gesture call back
+ (nullable UIView *)getViewFromCKComponent:(nullable id)component NS_SWIFT_NAME(getView(fromCKComponent:));

@end
