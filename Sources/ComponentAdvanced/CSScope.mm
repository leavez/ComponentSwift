//
//  CSScope.m
//  Pods
//
//  Created by Gao on 08/05/2017.
//
//

#import "CSScope.h"
#import <ComponentKit/ComponentKit.h>
#import <ComponentKit/CKComponentSubclass.h>
#import "CSObject+Convert.h"


@implementation CSScope {
    Class _class;
    NSString *_identifier;
    id (^_initialStateCreator)();
}

- (instancetype)initWithClass:(Class)cls identifier:(NSString *)identifier initialStateCreator:(id (^)())initialStateCreator {
    self = [super init];
    if (self) {
        _class = cls;
        _identifier = identifier;
        _initialStateCreator = initialStateCreator;
    }
    return self;
}

- (Class)cls {
    return _class;
}
- (NSString *)identifier {
    return _identifier;
}
- (id (^)())initialStateCreator {
    return _initialStateCreator;
}

@end
