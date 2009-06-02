#import <UIKit/UIKit.h>

@interface RootViewController : UITableViewController {
	NSArray *expenseReports;
	NSArray *toolbarItems;
//@private
//	NSArray* _toolbarItems;
}

@property(nonatomic, retain) NSArray* toolbarItems;
@property(nonatomic, retain) NSArray *expenseReports;

- (id)initWithToolbarItems:(NSArray*)items;
- (IBAction) doStuff;
- (NSArray *)toolBarItemsByCount:(NSInteger) count;

- (NSArray *)getExpenseReports;
@end
