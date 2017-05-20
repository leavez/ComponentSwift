//
//  CKWHostingView.m
//  Pods
//
//  Created by Gao on 20/05/2017.
//
//

#import "CKWHostingView.h"
#import "cppHeaders.h"


@interface CKWHostingViewSizeProvider : NSObject<CKComponentSizeRangeProviding>
@property (nonatomic, copy) CGSizeRange(^sizeRangeBlock)(CGSize boundingSize);
@end
@implementation CKWHostingViewSizeProvider
- (CKSizeRange)sizeRangeForBoundingSize:(CGSize)size {
    if (self.sizeRangeBlock) {
        CGSizeRange range = self.sizeRangeBlock(size);
        return CKSizeRange(range.min, range.max);

    }
    return CKSizeRange();
}
@end


@interface CKWHostingView()<CKComponentHostingViewDelegate>
@property (nonatomic) CKComponentHostingView *innerView;
@property (nonatomic) CKWHostingViewSizeProvider *sizeProvider;
@end

@implementation CKWHostingView


- (nonnull instancetype)initWithComponentProvider:(nonnull Class<CKWComponentProviderProtocol>)componentProvider
                                        sizeRange:(nonnull CGSizeRange(^)(CGSize boundingSize))sizeRangeBlock
{
    self = [super init];
    if (self) {
        Class provider = componentProvider;
        NSAssert([provider isSubclassOfClass:[NSObject class]], @"%@ should be sublcass of NSObject", NSStringFromClass(provider));
        let castedComponentProvider = (Class<CKComponentProvider>)provider;

        _sizeProvider = [CKWHostingViewSizeProvider new];
        _sizeProvider.sizeRangeBlock = sizeRangeBlock;

        _innerView = [[CKComponentHostingView alloc]
                      initWithComponentProvider:castedComponentProvider
                      sizeRangeProvider:_sizeProvider];
        _innerView.delegate = self;
        
        [self addSubview:_innerView];
        super.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (void)componentHostingViewDidInvalidateSize:(CKComponentHostingView *)hostingView {
    [self.delegate componentHostingViewDidInvalidateSize:self];
}


- (void)layoutSubviews {
    [super layoutSubviews];
    self.innerView.frame = self.bounds;
}


- (void)updateModel:(nullable id<NSObject>)model asynchronously:(BOOL)asynchronously {
    [self.innerView updateModel:model mode:asynchronously ? CKUpdateModeAsynchronous : CKUpdateModeSynchronous];
}

- (void)updateContext:(nullable id<NSObject>)context asynchronously:(BOOL)asynchronously {
    [self.innerView updateContext:context mode:asynchronously ? CKUpdateModeAsynchronous : CKUpdateModeSynchronous];
}

#pragma mark - override

- (void)setBackgroundColor:(UIColor *)backgroundColor {
    NSAssert(NO, @"BackgroundColor of CKWHostingView shouldn't be used. Set it in component.");
}



@end
