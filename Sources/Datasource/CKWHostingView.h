//
//  CKWHostingView.h
//  Pods
//
//  Created by Gao on 20/05/2017.
//
//

#import <UIKit/UIKit.h>
#import "CKWComponentProvider.h"
#import "CKWSize.h"
@protocol CKWHostingViewDelegate;


/** A view that renders a single component. */
/// for CKComponentHostingView
@interface CKWHostingView : UIView

/** Notified when the view's ideal size (measured by -sizeThatFits:) may have changed. */
@property (nonatomic, weak, nullable) id<CKWHostingViewDelegate> delegate;

/** Designated initializer. */
- (nonnull instancetype)initWithComponentProvider:(nonnull Class<CKWComponentProviderProtocol>)componentProvider
                                        sizeRange:(nonnull CGSizeRange(^)(CGSize boundingSize))sizeRangeBlock;

/** Updates the model used to render the component. */
- (void)updateModel:(nullable id)model asynchronously:(BOOL)asynchronously;

/** Updates the context used to render the component. */
- (void)updateContext:(nullable id)context asynchronously:(BOOL)asynchronously;


- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
@end



@protocol CKWHostingViewDelegate <NSObject>
@required
/**
 Called after the hosting view updates the component view to a new size.

 The delegate can use this callback to appropriately resize the view frame to fit the new
 component size. The view will not resize itself.
 */
- (void)componentHostingViewDidInvalidateSize:(nonnull CKWHostingView *)hostingView;
@end
