//
//  CSComponentAnimationProtocol.h
//  Pods
//
//  Created by Gao on 14/05/2017.
//
//

#import "CSOptionBase.h"
#import "CSComponent.h"

NS_ASSUME_NONNULL_BEGIN

// for CKComponentAnimation
NS_SWIFT_NAME(ComponentAnimation)
@interface CSComponentAnimation: CSOptionBase

- (nonnull instancetype)initWithComponent:(nonnull CSComponent *)component
                        animation:(nullable CAAnimation *)animation
                        layerPath:(nullable NSString *)layerPath NS_REFINED_FOR_SWIFT;


/// `context` in didRemount: The context returned by the willRemount block.
/// `context` in cleanup: The context returned by the didRemount block.
- (nonnull instancetype)initWithWillRemount:(id _Nullable(^)())willRemount
                         didRemount:(id _Nullable(^)(id _Nullable context))didRemount
                            cleanup:(void(^)(id _Nullable context))cleanup NS_REFINED_FOR_SWIFT;

@end

NS_ASSUME_NONNULL_END

NS_SWIFT_NAME(ComponentAnimationProtocol)
@protocol CSComponentAnimationProtocol

- (nullable NSArray<CSComponentAnimation *> *)animationsOnInitialMount;
- (nullable NSArray<CSComponentAnimation *> *)animationsFromPreviousComponent:(nullable CSComponent *)previousComponent;

@end


@interface CSComponent (animation)
- (nullable UIView *)viewForAnimation;
@end

