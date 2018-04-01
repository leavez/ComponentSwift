//
//  CKComponent+Injected.h
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import <ComponentKit/ComponentKit.h>
#import "CSComponent.h"

@interface CKComponent(Injected)

@property (nonatomic, readonly) CSComponent *wrapper;

- (void)setWrapperStrongly:(CSComponent *)wrapper;
- (void)setWrapperWeakly:(CSComponent *)wrapper;

- (id)nextResponderSkippedWrapper;

@end
