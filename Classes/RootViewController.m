#import "RootViewController.h"
#import "SQLiteInstanceManager.h"
#import "ExpenseReport.h"
#import "ExpenseReportItem.h"
#import "ExpenseType.h"
#import "Vendor.h"
#import "Currency.h"
#import "FrameworkX.h"
#import "SQLitePersistentObject+X.h"

#import "JSON.h"

@implementation RootViewController

@synthesize toolbarItems = _toolbarItems;
@synthesize expenseReports;

#define DATABASE_RESOURCE_NAME			@"expenseWorks"
#define DATABASE_RESOURCE_TYPE			@"db"
#define DATABASE_FILE_NAME				@"expenseWorks.db"


- (NSArray *)filesWithDirectoryPath:(NSString *)directoryPath filteredByExtension:(NSString *)pathExtension {
	NSMutableArray *ymlFiles = [NSMutableArray empty];
	NSDirectoryEnumerator *dirEnum = [[NSFileManager defaultManager] enumeratorAtPath:directoryPath];
	NSString *fileName;
	while (fileName = [dirEnum nextObject]) {
		if ([[fileName pathExtension] isEqualToString:pathExtension]) {
			[ymlFiles addObject:[NSString stringWithFormat:@"%@/%@", directoryPath, fileName]];
		}
	}
	return [ymlFiles autorelease];
}

- (void) loadFixtures {
	SBJSON *sbjson = [SBJSON new];
	sbjson.maxDepth = 5;
	
	
//	XHash *record1 = [XHash withVargs:
//		@"reportId", [NSNumber numberWithInt:10], 
//		@"submittedOn", @"abc",
//		nil
//	];
//	
//	NSLog(@"Crap");
//	
//	NSLog([record1 JSONRepresentation]);
//	NSLog([record1 JSONFragmentValue]);

//	NSString *jsonString = @"{\"reportId\":10,\"submittedOn\":\"abc\"}";
//	NSDictionary *record1 = (NSDictionary *)[sbjson objectWithString:jsonString error:NULL];
//	NSLog([[record1 objectForKey:@"reportId"] class]);
//	ExpenseType *expenseType = [[ExpenseType alloc] init];
//	[expenseType setPk:5];
	
	NSString *resourcePath = [[NSBundle mainBundle] resourcePath];

	NSArray *ymlFiles = [[self filesWithDirectoryPath:resourcePath filteredByExtension:@"yml"] retain];
	NSLog(@"Files are %@", ymlFiles);
	for (NSString *ymlFile in ymlFiles) {
		NSString *modelName = [[[NSFileManager defaultManager] displayNameAtPath:ymlFile] stringByDeletingPathExtension];
		id model = objc_getClass([modelName UTF8String]);
		
		NSString *jsonString = [[NSString alloc] initWithContentsOfFile:ymlFile];			
		NSArray *arrayOfRecords = (NSArray *)[sbjson objectWithString:jsonString error:NULL];
		NSLog(@"Processing: %@ which has %d records", [model class], [arrayOfRecords count]);
		for(NSDictionary *record in arrayOfRecords) {
			if ([record isEmpty]) {
				NSLog(@"You are crazy");
			}
			else {
				id modelInstance = [model createWithParams:record];
				NSLog(@"Modle instance %@", modelInstance);
			}

		}
	}	
}

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
	
	return TRUE;
}

- (NSString *)databaseFileNameWithPath {
	NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentFolderPath = [searchPaths objectAtIndex: 0];	
	return [documentFolderPath stringByAppendingPathComponent: DATABASE_FILE_NAME];
}

- (void) createTestExpenseReport {
	
//	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
//	[dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss.SSSS"];
//	[dateFormatter stringFromDate:[NSDate date]];	
//	XHash *record1 = [XHash withVargs:
//		@"reportId", @"06", 
//		@"createdOn", [dateFormatter stringFromDate:[NSDate date]],
//		@"submittedOn", [dateFormatter stringFromDate:[NSDate date]],
//		nil
//	];
	
//	"{"submittedOn":"2009-05-24 20:43:09 -0500","reportId":"03","createdOn":"2009-05-24 20:43:09 -0500"}"
	
	//NSString *jsonString = @"{\"submittedOn\":\"2009-05-24 21:17:43.2430\",\"reportId\":\"06\",\"createdOn\":\"2009-05-24 21:17:43.2430\"}";
	
//	
//	SBJSON *sbjson = [SBJSON new];
//	sbjson.maxDepth = 5;
//	NSDictionary *record1 = (NSDictionary *)[sbjson objectWithString:jsonString error:NULL];
	//NSLog(@"Dic is: %@", record);
	
//	ExpenseReport *expenseReport = [ExpenseReport createWithParams:record1];
	
//	NSString *jsonString = [record1 JSONRepresentation];
//	NSLog(@"Json string is:");
//	NSLog(jsonString);
//	ExpenseReport *expenseReport = [ExpenseReport newWithParams:record1];
//	ExpenseReport *expenseReport = [ExpenseReport createWithParams:record1];
//	NSLog([expenseReport description]);
	
//	for (NSString *key in [record1 allKeys]) {
//		NSString *propertyName = (NSString *)[[NSString stringWithFormat:@"set_%@:", key] asCamelCase];
////		NSLog(propertyName);
////		NSLog([NSString stringWithFormat:@"set_%@:", key ]);
////		NSString *propertyName = (NSString *)[[@"set_" append:key] asCamelCase];
//		[expenseReport performSelector:NSSelectorFromString(propertyName) withObject:[record1 valueForKey:key]];
//	}
//	
//	NSLog([expenseReport description]);
	
//	ExpenseReport *expenseReport = [[ExpenseReport alloc] init];
//	[expenseReport performSelector:NSSelectorFromString(@"setReportId:") withObject:@"05"];
//	NSLog(@"val is: %@", expenseReport.reportId);
	
}

- (void)initDatabaseConnection {
	SQLiteInstanceManager *manager = [SQLiteInstanceManager sharedManager];
	manager.databaseFilepath = [self databaseFileNameWithPath];
}

- (void)printDatabaseStructure {
	NSString *sqlString = [NSString stringWithFormat: @"sqlite3 '%@' .schema", [self databaseFileNameWithPath]];
	NSLog(sqlString);
	printf("The schema is \n");
	system([sqlString UTF8String]);
	printf("\n");
	
	NSMutableArray *modelNames = (NSMutableArray *)[NSArray withVargs:@"expense_report", @"expense_report_item", @"vendor", @"expense_type", nil];
	
	for(NSString *modelName in modelNames) {
		//print expense_report
		sqlString = [NSString stringWithFormat: @"sqlite3 -header -column '%@' 'select * from %@'", 
					 [self databaseFileNameWithPath], modelName];
		NSLog(sqlString);
		printf("The values in expense_report_item are: \n");
		system([sqlString UTF8String]);
		printf("\n");		
	}
//	//print expense_report
//	sqlString = [NSString stringWithFormat: @"sqlite3 -header -column '%@' 'select * from expense_report'", 
//				 [self databaseFileNameWithPath]];
//	NSLog(sqlString);
//	printf("The values in expense_report_item are: \n");
//	system([sqlString UTF8String]);
//	printf("\n");
//	
//	//print expense report item
//	sqlString = [NSString stringWithFormat: @"sqlite3 -header -column '%@' 'select * from expense_report_item'", 
//				 [self databaseFileNameWithPath]];
//	NSLog(sqlString);
//	printf("The values in expense_report_item are: \n");
//	system([sqlString UTF8String]);
//	printf("\n");
	
}

- (NSArray *)getExpenseReports {
	
	
//	[self createTestExpenseReport];
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
//	expenseReport = [[ExpenseReport alloc] init];
//	expenseReport.reportId = @"05";
//	expenseReport.createdOn = [NSDate date];
//	expenseReport.submittedOn = [NSDate date];
//	
//	[expenseReport save];
//	
//	expenseReportItem = [[ExpenseReportItem alloc] init];
//	[expenseReportItem setPk:11];
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
//	
//	NSArray *expenseTypes = 
//		[[NSArray alloc] initWithObjects: @"Business Meal", @"Flight", @"Benefit", @"Books", @"Car Rental",
//		 @"Conference", @"Due Subscriptions", @"Gas", @"High Speed Internet", @"Hotel", @"Local Transportation",
//		 @"Mileage and Tolls", @"Office Supplies", @"Other", @"Passport", @"Postage & Shipping",
//		 @"Stipend - UK/US", @"Telephone", @"Training/Education", nil
//		 ];
//	
//	ExpenseType *expenseType;
//	for(NSString *expenseTypeName in expenseTypes) {
//		expenseType = [[ExpenseType alloc] init];
//		expenseType.name = expenseTypeName;
//		[expenseType save];
//	}	
	
//		
//	//Flights Vendor
//	expenseTypes = [ExpenseType findByName:@"Flight"];
//	expenseType = [expenseTypes objectAtIndex:0];
//	
//	NSArray *flightVendors = [[NSArray alloc] initWithObjects:@"Cliqbook", @"United", @"American", @"Southwest", @"Delta", nil];
//	for (NSString *name in flightVendors) {
//		Vendor *vendor = [[Vendor alloc] init];
//		vendor.name = name;
//		vendor.expenseType = expenseType;
//		[vendor save];		
//	}
//	
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
//
//	//Hotel Vendors
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
//	
//	
//	//Currency
//	NSArray *currencies = [[NSArray alloc] initWithObjects: @"Australian AUD $", @"Euro €", @"British GBP £", @"Indian INR ₨", @"Chinese RMB ¥", @"United States USD $", nil];
//	
//	for(NSString *currencyName in currencies) {
//		Currency *currency = [[Currency alloc] init];
//		currency.name = currencyName;
//		currency.lastSelectedOn = [NSDate date];
//		[currency save];
//	}	
//	NSLog(@"Currencies: %@", [Currency findByCriteria:@" ORDER BY last_selected_on DESC"]);
//	

//	//Testing FrameworkX
//	NSArray *paymentType = [NSArray empty];
	
//	NSArray *p = [NSArray withVargs:@"fooSize", @"barDing", nil];
//	NSLog(@"Values are: %@", [[p collect] asRubyCase]);
	
	return [ExpenseReport findByCriteria:@""];
}

- (void)viewDidLoad {
 	if (([self initDatabase]) == FALSE) NSLog(@"Could not initiated databse");
	[self initDatabaseConnection];
//	[self loadFixtures];
	[self printDatabaseStructure];
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

