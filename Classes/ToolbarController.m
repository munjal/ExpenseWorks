//
//  CWToolbarController.m
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

#import "ToolbarController.h"


@implementation ToolbarController

@synthesize contentViewController = _contentViewController;
@synthesize toolbar = _toolbar;

- (id)initWithContentViewController:(UIViewController*)contentViewController;
{
	self = [super init];
	if (self) {
		_contentViewController = [contentViewController retain];
		if ([_contentViewController isKindOfClass:[UINavigationController class]]) {
			((UINavigationController*)_contentViewController).delegate = self;
		}
	}
	return self;
}

- (void)loadView;
{
	UIView* contentView = _contentViewController.view;
	CGRect frame = contentView.frame;
	UIView* view = [[UIView alloc] initWithFrame:frame];
	
	frame = CGRectMake(0, 0, frame.size.width, frame.size.height - 44.0f);
	contentView.frame = frame;
	[view addSubview:contentView];

	frame = CGRectMake(0.0f, frame.size.height, frame.size.width, 44.0f);
	_toolbar = [[UIToolbar alloc] initWithFrame:frame];
	[view addSubview:_toolbar];

	self.view = view;
	[view release];
	[_toolbar release];
}

- (void)navigationController:(UINavigationController *)navigationController 
        willShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
{
	NSArray* items = nil;
	if ([viewController respondsToSelector:@selector(toolbarItems)]) {
		items = [viewController performSelector:@selector(toolbarItems)];
	}
	[_toolbar setItems:items animated:animated];
}

- (void)dealloc
{
	[_contentViewController release];
    [super dealloc];
}

@end
