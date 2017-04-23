//
//  CKComponnet+Injected.h
//  Pods
//
//  Created by Gao on 22/04/2017.
//
//

#import <ComponentKit/ComponentKit.h>
#import "CKWComponent.h"

@interface CKComponent(Injected)

@property (nonatomic, readonly) CKWComponent *wrapper;

- (void)setWrapperStrongly:(CKWComponent *)wrapper;
- (void)setWrapperWeakly:(CKWComponent *)wrapper;

- (id)nextResponderSkippedWrapper;

@end
