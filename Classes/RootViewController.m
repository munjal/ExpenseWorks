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

- (BOOL) copyDatabaseAndInitFixtures {
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
	[[NSFileManager defaultManager] copyItemAtPath:backupDatabasePath toPath:[self databaseFileNameWithPath] error:nil];
	
	[self initDatabaseConnection];
	[self loadFixtures];
	[self printDatabaseStructure];	
	
	return TRUE;
}

- (NSString *)databaseFileNameWithPath {
	NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentFolderPath = [searchPaths objectAtIndex: 0];	
	return [documentFolderPath stringByAppendingPathComponent: DATABASE_FILE_NAME];
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
	
	NSMutableArray *modelNames = (NSMutableArray *)[NSArray withVargs:@"expense_report", 
													@"expense_report_item", 
													@"vendor", 
													@"expense_type", 
													@"currency",
													@"project",
													@"attendee",
													nil];
	
	for(NSString *modelName in modelNames) {
		//print expense_report
		sqlString = [NSString stringWithFormat: @"sqlite3 -header -column '%@' 'select * from %@'", 
					 [self databaseFileNameWithPath], modelName];
		NSLog(sqlString);
		printf("The values in expense_report_item are: \n");
		system([sqlString UTF8String]);
		printf("\n");		
	}
}

- (NSArray *)getExpenseReports {
	return [ExpenseReport findByCriteria:@""];
}

- (void)viewDidLoad {
 	[self copyDatabaseAndInitFixtures];
	[self initDatabaseConnection];
	
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

