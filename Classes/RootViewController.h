#import <UIKit/UIKit.h>
#import "ToolbarController.h"

@interface RootViewController : UITableViewController {
	NSArray *expenseReports;
@private
	NSArray* _toolbarItems;
}

@property(nonatomic, retain) NSArray* toolbarItems;
@property(nonatomic, retain) NSArray *expenseReports;

- (id)initWithToolbarItems:(NSArray*)items;
- (IBAction) doStuff;
- (NSArray *)toolBarItemsByCount:(NSInteger) count;

- (void)initDatabaseConnection;
- (void)printDatabaseStructure;
- (BOOL) copyDatabaseAndInitFixtures;
- (NSString *)databaseFileNameWithPath;
- (NSArray *)getExpenseReports;
@end
