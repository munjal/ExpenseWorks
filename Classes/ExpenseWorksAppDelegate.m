#import "ExpenseWorksAppDelegate.h"
#import "ToolbarController.h"
#import "RootViewController.h"
#import "NewExpenseReportItemController.h"
#import "ExpenseTypesController.h"
#import "SQLitePersistentObject+X.h"
#import "SQLiteInstanceManager.h"


@implementation ExpenseWorksAppDelegate
#define DATABASE_RESOURCE_NAME			@"expenseWorks"
#define DATABASE_RESOURCE_TYPE			@"db"
#define DATABASE_FILE_NAME				@"expenseWorks.db"


@synthesize window;
- (void)applicationDidFinishLaunching:(UIApplication *)application {
	NSArray* toolbarItems = [NSArray arrayWithObjects:
			[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil],				 
			[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showNewExpenseReportItemController)],
			nil];
	[toolbarItems makeObjectsPerformSelector:@selector(release)];
	
	[self copyDatabaseAndInitFixtures];
	[self initDatabaseConnection];
	
	RootViewController* rootController = [[RootViewController alloc] initWithToolbarItems:toolbarItems];
	navController = [[UINavigationController alloc] initWithRootViewController:rootController];
	ToolbarController* toolbarController = [[ToolbarController alloc] initWithContentViewController:navController];
		
	[window addSubview:toolbarController.view];
	
	[window makeKeyAndVisible];
}

- (IBAction) showNewExpenseReportItemController {
	ExpenseTypesController *expenseTypesController = [[ExpenseTypesController alloc] init];
	[navController pushViewController: expenseTypesController animated:TRUE];
}

- (NSString *)databaseFileNameWithPath {
	NSArray *searchPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentFolderPath = [searchPaths objectAtIndex: 0];	
	return [documentFolderPath stringByAppendingPathComponent: DATABASE_FILE_NAME];
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

- (void)initDatabaseConnection {
	SQLiteInstanceManager *manager = [SQLiteInstanceManager sharedManager];
	manager.databaseFilepath = [self databaseFileNameWithPath];
}

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

- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
