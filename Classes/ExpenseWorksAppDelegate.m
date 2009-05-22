#import "ExpenseWorksAppDelegate.h"
#import "ToolbarController.h"
#import "RootViewController.h"
#import "NewExpenseReportItemController.h"
#import "ExpenseTypesController.h"

@implementation ExpenseWorksAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	NSArray* toolbarItems = [NSArray arrayWithObjects:
			[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil],				 
			[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(showNewExpenseReportItemController)],
			nil];
	[toolbarItems makeObjectsPerformSelector:@selector(release)];
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


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
