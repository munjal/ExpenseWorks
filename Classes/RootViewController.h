#import <UIKit/UIKit.h>
#import "ToolbarController.h"
#import "SQLiteInstanceManager.h"
#import "ExpenseReport.h"
#import "ExpenseReportItem.h"

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

- (BOOL) initDatabase;
- (NSString *)databaseFileNameWithPath;
- (NSArray *)getExpenseReports;
@end
