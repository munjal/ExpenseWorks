#import <UIKit/UIKit.h>

@interface ExpenseWorksAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (IBAction) doStuff;

@end

