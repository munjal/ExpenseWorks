#import <UIKit/UIKit.h>

@interface ToolbarController : UIViewController <UINavigationControllerDelegate> {
@private
	UIViewController* _contentViewController;
	UIToolbar* _toolbar;
}

@property(nonatomic, retain, readonly) UIViewController* contentViewController;
@property(nonatomic, retain, readonly) UIToolbar* toolbar;

-(id)initWithContentViewController:(UIViewController*)contentViewController;

@end
