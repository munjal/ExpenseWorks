//
//  NewExpenseReportItemController.m
//  ExpenseWorks
//
//  Created by mbudhabh on 5/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewExpenseReportItemController.h"


@implementation NewExpenseReportItemController
@synthesize projectCode;
@synthesize expenseType;
@synthesize vendorPickerView;
@synthesize vendorPickerItems;
@synthesize vendor;

#pragma mark ---- UIPickerViewDataSource delegate methods ----

// returns the number of columns to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	NSLog(@"numberOfComponentsInPickerView");
	return 1;
}

// returns the number of rows
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	NSLog(@"number of rows");
	return [vendorPickerItems count];
}


#pragma mark ---- UIPickerViewDelegate delegate methods ----
// returns the title of each row
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	NSLog(@"title of each row");
	Vendor *currentVendor = [vendorPickerItems objectAtIndex:row];
	return currentVendor.name;
}

// gets called when the user settles on a row
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	vendor = [vendorPickerItems objectAtIndex:row];
}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self.projectCode setText:self.expenseType.name];
	self.vendorPickerItems =  [[NSArray alloc] initWithArray:[Vendor findByExpenseType:self.expenseType]];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
