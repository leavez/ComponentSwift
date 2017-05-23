//
//  CSChangeSet+Build.h
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

#import "CSChangeSet.h"
#import <ComponentKit/ComponentKit.h>

@interface CSChangeSet (build)
- (CKTransactionalComponentDataSourceChangeset *)build;
@end

