//
//  CWTestTableController.m
//  ExpenseWorks
//
//  Created by Fredrik Olsson on 2009-03-22.
//  Copyright 2009 Jayway. All rights reserved.
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//      * Redistributions of source code must retain the above copyright
//        notice, this list of conditions and the following disclaimer.
//      * Redistributions in binary form must reproduce the above copyright
//        notice, this list of conditions and the following disclaimer in the
//        documentation and/or other materials provided with the distribution.
//      * Neither the name of the <organization> nor the
//        names of its contributors may be used to endorse or promote products
//        derived from this software without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY <copyright holder> ''AS IS'' AND ANY
//  EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL <copyright holder> BE LIABLE FOR ANY
//  DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.//

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
	NSArray* nextItems = [self toolBarItemsByCount: MAX([self.toolbarItems count] - 1, 0)];
	RootViewController* nextController = [[RootViewController alloc] initWithToolbarItems:nextItems];
	[self.navigationController pushViewController:nextController animated:YES];
	[nextController release];
}

- (NSArray *)toolBarItemsByCount:(NSInteger) count {
	NSArray* toolbarItems = [NSArray arrayWithObjects:
							 [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(doStuff)],
							 [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(doStuff)],
							 [[UIBarButtonItem alloc] initWithTitle:@"Foo" style:UIBarButtonItemStylePlain target:self action:@selector(doStuff)],
							 [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(doStuff)],
							 [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(doStuff)],
							 [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(doStuff)],
							 [[UIBarButtonItem alloc] initWithTitle:@"Bar" style:UIBarButtonItemStyleBordered target:self action:@selector(doStuff)],
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

