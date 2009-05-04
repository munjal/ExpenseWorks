#import "RootViewController.h"

@implementation RootViewController

@synthesize toolbarItems = _toolbarItems;

- (id)initWithToolbarItems:(NSArray*)items;
{
    if (self = [super initWithStyle:UITableViewStylePlain]) {
		self.toolbarItems = items;
		self.title = [NSString stringWithFormat:@"Level %d", 7 - [items count]];
    }
    return self;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

#pragma mark Table view methods


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero reuseIdentifier:CellIdentifier] autorelease];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
	cell.text = [NSString stringWithFormat:@"Row %d", indexPath.row];
	
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	//NSArray* nextItems = [self.toolbarItems subarrayWithRange:NSMakeRange(0, MAX([self.toolbarItems count] - 1, 0))];
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
}


@end

