#import "ExpenseWorksAppDelegate.h"
#import "RootViewController.h"
#import "ToolbarController.h"

@implementation ExpenseWorksAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	NSArray* toolbarItems = [NSArray arrayWithObjects:
			[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(doStuff)],				 
			[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(doStuff)],
			nil];
	[toolbarItems makeObjectsPerformSelector:@selector(release)];
	RootViewController* rootController = [[RootViewController alloc] initWithToolbarItems:toolbarItems];
	UINavigationController* navController = [[UINavigationController alloc] initWithRootViewController:rootController];
	ToolbarController* toolbarController = [[ToolbarController alloc] initWithContentViewController:navController];
		
	[window addSubview:toolbarController.view];
	
	[window makeKeyAndVisible];
}

- (IBAction) doStuff {
	NSLog(@"Do some stuff");
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
