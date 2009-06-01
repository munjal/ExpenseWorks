#import <UIKit/UIKit.h>
#import "JSON.h"

@interface ExpenseWorksAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	UINavigationController* navController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (IBAction) showNewExpenseReportItemController;

- (NSString *)databaseFileNameWithPath;
- (BOOL) copyDatabaseAndInitFixtures;
- (void)initDatabaseConnection;
- (void) loadFixtures;
- (void)printDatabaseStructure;


@end

