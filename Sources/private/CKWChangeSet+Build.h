//
//  CKWChangeSet+Build.h
//  Pods
//
//  Created by Gao on 06/05/2017.
//
//

#import "CKWChangeSet.h"
#import <ComponentKit/ComponentKit.h>

@interface CKWChangeSet (build)
- (CKTransactionalComponentDataSourceChangeset *)build;
@end

