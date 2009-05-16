#import <UIKit/UIKit.h>

@interface ExpenseWorksAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController* navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (IBAction) showNewExpenseReportItemController;

@end

