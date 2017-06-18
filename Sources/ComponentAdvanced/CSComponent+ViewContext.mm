//
//  CSComponent+ViewContext.m
//  Pods
//
//  Created by Gao on 15/06/2017.
//
//

#import "CSComponent+ViewContext.h"
#import <ComponentKit/CKComponent.h>

@implementation CSComponent(ViewContext)

+ (UIView *)getViewFromCKComponent:(id)component {
    if ([component isKindOfClass:[CKComponent class]]) {
        return [(CKComponent *)component viewContext].view;
    }
    return nil;
}

@end
