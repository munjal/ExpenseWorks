//
//  ExpenseWorksAppDelegate.m
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

#import "ExpenseWorksAppDelegate.h"
#import "RootViewController.h"
#import "ToolbarController.h"

@implementation ExpenseWorksAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	NSArray* toolbarItems = [NSArray arrayWithObjects:
	        [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(doStuff)],
			[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(doStuff)],
			[[UIBarButtonItem alloc] initWithTitle:@"Foo" style:UIBarButtonItemStylePlain target:self action:@selector(doStuff)],
			[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:@selector(doStuff)],
			[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh target:self action:@selector(doStuff)],
			[[UIBarButtonItem alloc] initWithTitle:@"Bar" style:UIBarButtonItemStyleBordered target:self action:@selector(doStuff)],
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
