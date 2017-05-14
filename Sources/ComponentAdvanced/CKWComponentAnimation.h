//
//  CKWComponentAnimationProtocol.h
//  Pods
//
//  Created by Gao on 14/05/2017.
//
//

#import "CKWCreatorBase.h"
#import "CKWComponent.h"

NS_ASSUME_NONNULL_BEGIN
@interface CKWComponentAnimation: CKWCreatorBase

- (nonnull instancetype)initWithComponent:(nonnull CKWComponent *)component
                        animation:(nullable CAAnimation *)animation
                        layerPath:(nullable NSString *)layerPath;


/// `context` in didRemount: The context returned by the willRemount block.
/// `context` in cleanup: The context returned by the didRemount block.
- (nonnull instancetype)initWithWillRemount:(id _Nullable(^)())willRemount
                         didRemount:(id _Nullable(^)(id context))didRemount
                            cleanup:(void(^)(id _Nullable context))cleanup;
@end

NS_ASSUME_NONNULL_END


@protocol CKWComponentAnimationProtocol

- (nullable NSArray<CKWComponentAnimation *> *)animationsOnInitialMount;
- (nullable NSArray<CKWComponentAnimation *> *)animationsFromPreviousComponent:(nullable CKWComponent *)previousComponent;

@end

