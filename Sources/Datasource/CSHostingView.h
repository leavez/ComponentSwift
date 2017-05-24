//
//  CSHostingView.h
//  Pods
//
//  Created by Gao on 20/05/2017.
//
//

#import <UIKit/UIKit.h>
#import "CSComponentProvider.h"
#import "CSSize.h"
NS_SWIFT_NAME(HostingViewDelegate)
@protocol CSHostingViewDelegate;


/** A view that renders a single component. */
/// for CKComponentHostingView
NS_SWIFT_NAME(HostingView)
@interface CSHostingView : UIView

/** Notified when the view's ideal size (measured by -sizeThatFits:) may have changed. */
@property (nonatomic, weak, nullable) id<CSHostingViewDelegate> delegate;

/** Designated initializer. */
- (nonnull instancetype)initWithComponentProvider:(nonnull Class<CSComponentProviderProtocol>)componentProvider
                                        sizeRange:(nonnull CGSizeRange(^)(CGSize boundingSize))sizeRangeBlock;

/** Updates the model used to render the component. */
- (void)updateModel:(nullable id)model asynchronously:(BOOL)asynchronously;

/** Updates the context used to render the component. */
- (void)updateContext:(nullable id)context asynchronously:(BOOL)asynchronously;


- (nonnull instancetype)init NS_UNAVAILABLE;
- (nonnull instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
@end


// for CKComponentHostingViewDelegate
NS_SWIFT_NAME(HostingViewDelegate)
@protocol CSHostingViewDelegate <NSObject>
@required
/**
 Called after the hosting view updates the component view to a new size.

 The delegate can use this callback to appropriately resize the view frame to fit the new
 component size. The view will not resize itself.
 */
- (void)componentHostingViewDidInvalidateSize:(nonnull CSHostingView *)hostingView;
@end
