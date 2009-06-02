#import "RootViewController.h"
#import "ToolbarController.h"
#import "ExpenseReport.h"
#import "ExpenseReportItem.h"
#import "ExpenseType.h"
#import "Vendor.h"
#import "Currency.h"
#import "FrameworkX.h"
#import "SQLitePersistentObject+X.h"



@implementation RootViewController

@synthesize toolbarItems;
@synthesize expenseReports;

- (NSArray *)getExpenseReports {
	return [ExpenseReport findByCriteria:@""];
}

- (void)viewDidLoad {	
	self.expenseReports =  [[NSArray alloc] initWithArray:[self getExpenseReports]];
}


- (id)initWithToolbarItems:(NSArray*)items;
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
		self.toolbarItems = items;
		self.title = @"Expense Report Index";
    }
    return self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark Table view methods


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return [self.expenseReports count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	ExpenseReport *expenseReport = (ExpenseReport *)[self.expenseReports objectAtIndex:indexPath.row];
	cell.text = [NSString stringWithFormat:@"%@ on %@", expenseReport.reportId, expenseReport.submittedOn];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	NSArray* nextItems = [self toolBarItemsByCount: MAX([self.toolbarItems count], 0)];
	RootViewController* nextController = [[RootViewController alloc] initWithToolbarItems:nextItems];
	[self.navigationController pushViewController:nextController animated:YES];
	[nextController release];
}

- (NSArray *)toolBarItemsByCount:(NSInteger) count {
	self.toolbarItems = [NSArray arrayWithObjects:
							 [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(doStuff)],				 
							 [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(doStuff)],
							 nil];
	[toolbarItems makeObjectsPerformSelector:@selector(release)];
	return [toolbarItems subarrayWithRange:NSMakeRange(0, count)];
}

- (IBAction) doStuff {
	NSLog(@"Do some VERY cool stuff");
}


- (void)dealloc {
    [super dealloc];
	[expenseReports release];
}


@end

