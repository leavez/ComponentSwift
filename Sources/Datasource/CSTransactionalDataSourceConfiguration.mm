//
//  CSTransactionalDataSourceConfiguration.m
//  Pods
//
//  Created by Gao on 31/05/2017.
//
//

#import "CSTransactionalDataSourceConfiguration.h"
#import "CSObject+Convert.h"

@implementation CSTransactionalDataSourceConfiguration {
    id _context;
    Class<CSComponentProviderProtocol> _componentProvider;
    CGSizeRange _sizeRange;
}
- (instancetype)initWithComponentProvider:(Class<CSComponentProviderProtocol>)componentProvider context:(id)context sizeRange:(CGSizeRange)sizeRange {
    self = [super init];
    if (self) {
        Class provider = componentProvider;
        NSAssert([provider isSubclassOfClass:[NSObject class]], @"%@ should be sublcass of NSObject", NSStringFromClass(provider));

        _context = context;
        _componentProvider = provider;
        _sizeRange = sizeRange;
    }
    return self;
}

- (CGSizeRange)sizeRange {
    return _sizeRange;
}

- (Class<CSComponentProviderProtocol>)componentProvider {
    return _componentProvider;
}

- (id)context {
    return _context;
}

- (CKTransactionalComponentDataSourceConfiguration *)convert {

    // force cast
    let castedComponentProviderClass = (Class<CKComponentProvider>)_componentProvider;

    return [[CKTransactionalComponentDataSourceConfiguration alloc] initWithComponentProvider:castedComponentProviderClass context:_context sizeRange:CKSizeRange(_sizeRange.min, _sizeRange.max)];
}

@end
