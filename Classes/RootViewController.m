#import "RootViewController.h"
#import "SQLiteInstanceManager.h"
#import "ExpenseReport.h"
#import "ExpenseReportItem.h"
#import "ExpenseType.h"
#import "Vendor.h"
#import "Currency.h"

@implementation RootViewController

@synthesize toolbarItems = _toolbarItems;
@synthesize expenseReports;

#define DATABASE_RESOURCE_NAME			@"expenseWorks"
#define DATABASE_RESOURCE_TYPE			@"db"
#define DATABASE_FILE_NAME				@"expenseWorks.db"


- (BOOL) initDatabase {
	if ([[NSFileManager defaultManager] fileExistsAtPath: [self databaseFileNameWithPath]]) {
		NSLog(@"File already exists");
		return TRUE;
	}
		
	NSString *backupDatabasePath = [[NSBundle mainBundle] pathForResource:DATABASE_RESOURCE_NAME ofType:DATABASE_RESOURCE_TYPE]; 
	
	if (backupDatabasePath == nil) {
		NSLog(@"Database file does not exist on the target");
		return FALSE;
	}
		
	NSLog(@"Copying database file");
	return [[NSFileManager defaultManager] copyItemAtPath:backupDatabasePath toPath:[self databaseFileNameWithPath] error:nil];
}

- (NSString *)databaseFileNameWithPath {
	NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentFolderPath = [searchPaths objectAtIndex: 0];
	return [documentFolderPath stringByAppendingPathComponent: DATABASE_FILE_NAME];
}

- (NSArray *)getExpenseReports {
	SQLiteInstanceManager *manager = [SQLiteInstanceManager sharedManager];
	manager.databaseFilepath = [self databaseFileNameWithPath];
	
//	ExpenseReport *expenseReport = [[ExpenseReport alloc] init];
//	expenseReport.reportId = @"03";
//	expenseReport.createdOn = [NSDate date];
//	expenseReport.submittedOn = [NSDate date];
//
//	[expenseReport save];
//	
//	ExpenseReportItem *expenseReportItem = [[ExpenseReportItem alloc] init];
//	expenseReportItem.reportId = @"03";
//	expenseReportItem.expenseReport = expenseReport;
//	expenseReportItem.project = @"RACKSPACE";
//	expenseReportItem.category = @"airfare";
//	expenseReportItem.date = [NSDate date];
//	expenseReportItem.currency = @"USD";
//	expenseReportItem.amount = 987.34;
//	expenseReportItem.remarks = @"Airfare to Las Vegas";
//	expenseReportItem.vendor = @"American";
//	expenseReportItem.payment = @"card";
//	expenseReportItem.attendes = @"me";
//	[expenseReportItem save];

	
//	ExpenseReport *expenseReport = [[ExpenseReport alloc] init];
//	expenseReport.reportId = @"05";
//	expenseReport.createdOn = [NSDate date];
//	expenseReport.submittedOn = [NSDate date];
//	
//	[expenseReport save];
//	
//	ExpenseReportItem *expenseReportItem = [[ExpenseReportItem alloc] init];
//	expenseReportItem.reportId = @"05";
//	expenseReportItem.expenseReport = expenseReport;
//	expenseReportItem.project = @"RACKSPACE";
//	expenseReportItem.category = @"hotel";
//	expenseReportItem.date = [NSDate date];
//	expenseReportItem.currency = @"USD";
//	expenseReportItem.amount = 450.99;
//	expenseReportItem.remarks = @"Hotel";
//	expenseReportItem.vendor = @"Marriott";
//	expenseReportItem.payment = @"card";
//	expenseReportItem.attendes = @"me";
//	[expenseReportItem save];
	
//	NSArray *expenseTypes = 
//		[[NSArray alloc] initWithObjects: @"Business Meal", @"Flight", @"Benefit", @"Books", @"Car Rental",
//		 @"Conference", @"Due Subscriptions", @"Gas", @"High Speed Internet", @"Hotel", @"Local Transportation",
//		 @"Mileage and Tolls", @"Office Supplies", @"Other", @"Passport", @"Postage & Shipping",
//		 @"Stipend - UK/US", @"Telephone", @"Training/Education", nil
//		 ];
//	
//	for(NSString *expenseTypeName in expenseTypes) {
//		ExpenseType *expenseType = [[ExpenseType alloc] init];
//		expenseType.name = expenseTypeName;
//		[expenseType save];
//	}	
//	ExpenseType *expenseType = [[ExpenseType alloc] init];
//	expenseType.name = @"BusinessMeal";
//	NSString *sqlString = [NSString stringWithFormat: @"sqlite3 '%@' .schema", [self databaseFileNameWithPath]];
//	NSLog(sqlString);
//	printf("The schema is \n");
//	system([sqlString UTF8String]);
//	printf("\n");
//	
//	sqlString = [NSString stringWithFormat: @"sqlite3 -header -column '%@' 'select * from expense_report_item'", 
//				 [self databaseFileNameWithPath]];
//	NSLog(sqlString);
//	printf("The values in expense_report_item are: \n");
//	system([sqlString UTF8String]);
//	printf("\n");
//	
//	id expenseReportItems = [ExpenseReportItem findByCriteria:@"where expense_report like 'ExpenseReport%'"];
//	NSLog(@"expense report items: %@", expenseReportItems);

	//ExpenseReport *expenseReport = [ExpenseReport findByCriteria:@"where pk =1"];
//	NSString *criteria = [NSString stringWithFormat:@"where expense_report = 'ExpenseReport-%d'", 1];
//	id expenseReportItems = [ExpenseReportItem findByCriteria:criteria];
//	NSLog(@"expense report are: %@", expenseReportItems);
//
//	id expenseTypes = [ExpenseType allObjects];
//	NSLog(@"expense types are: %@", expenseTypes);
	
	//Flights Vendor
//	id expenseTypes = [ExpenseType findByName:@"Flight"];
//	ExpenseType *expenseType = [expenseTypes objectAtIndex:0];
//	
//	NSArray *flightVendors = [[NSArray alloc] initWithObjects:@"Cliqbook", @"United", @"American", @"Southwest", @"Delta", nil];
//	for (NSString *name in flightVendors) {
//		Vendor *vendor = [[Vendor alloc] init];
//		vendor.name = name;
//		vendor.expenseType = expenseType;
//		[vendor save];		
//	}
	
//	//Car Vendors
//	id carRentalExpenseTypes = [ExpenseType findByName:@"Car Rental"];
//	ExpenseType *carRentalExpenseType = [carRentalExpenseTypes objectAtIndex:0];
//	NSArray *carVendors = [[NSArray alloc] initWithObjects:@"Cliqbook", @"Avis", @"Hertz", @"Enterprise", @"Alamo", @"Thrifty", nil];	
//	for (NSString *name in carVendors) {
//		Vendor *vendor = [[Vendor alloc] init];
//		vendor.name = name;
//		vendor.expenseType = carRentalExpenseType;
//		[vendor save];		
//	}

	//Hotel Vendors
//	id hotelExpenseTypes = [ExpenseType findByName:@"Hotel"];
//	ExpenseType *hotelExpenseType = [hotelExpenseTypes objectAtIndex:0];
//	NSArray *hotelVendors = [[NSArray alloc] initWithObjects:@"Cliqbook", @"Marriott", @"Hilton", @"Starwood", @"Hyatt", nil];	
//	for (NSString *name in hotelVendors) {
//		Vendor *vendor = [[Vendor alloc] init];
//		vendor.name = name;
//		vendor.expenseType = hotelExpenseType;
//		[vendor save];		
//	}
//	NSLog(@"Vendors: %@", [Vendor allObjects]);
	
	
	//Currency
//	NSArray *currencies = [[NSArray alloc] initWithObjects: @"Australian AUD $", @"Euro €", @"British GBP £", @"Indian INR ₨", @"Chinese RMB ¥", @"United States USD $", nil];
//	
//	for(NSString *currencyName in currencies) {
//		Currency *currency = [[Currency alloc] init];
//		currency.name = currencyName;
//		currency.lastSelectedOn = [NSDate date];
//		[currency save];
//	}	
//	NSLog(@"Currencies: %@", [Currency findByCriteria:@" ORDER BY last_selected_on DESC"]);
	


//	id expenseReportsItems = [ExpenseReportItem findByCriteria:@"where "]
	
//	id expenseReportItems = [ExpenseReportItem findByCriteria:@"where 1 = 1"];
//	NSLog(@"expense report items are: %@", expenseReportItems);
//	
	return [ExpenseReport findByCriteria:@""];
}

- (void)viewDidLoad {
 	if (([self initDatabase]) == FALSE) NSLog(@"Could not initiated databse");
	
	self.expenseReports =  [[NSArray alloc] initWithArray:[self getExpenseReports]];
}


- (id)initWithToolbarItems:(NSArray*)items;
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
		self.toolbarItems = items;
		self.title = @"Expense Report Index";
		//self.title = [NSString stringWithFormat:@"Level %d", 7 - [items count]];
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
	NSArray* toolbarItems = [NSArray arrayWithObjects:
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

