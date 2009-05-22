//
//  NewExpenseReportItemController.m
//  ExpenseWorks
//
//  Created by mbudhabh on 5/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "NewExpenseReportItemController.h"


@implementation NewExpenseReportItemController

@synthesize expenseType, vendor;
@synthesize mainView, scrollView, contentView, navigationPopupView, datePickerView, genericPickerView;
@synthesize vendorField, dateField, currencyField, amountField, projectField, attendesField, textFields;
@synthesize previousButton, nextButton, doneButton;

//@synthesize vendorPickerView, vendorPickerItems, vendor;

//#pragma mark ---- UIPickerViewDataSource delegate methods ----
//
//// returns the number of columns to display.
//- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
//	NSLog(@"numberOfComponentsInPickerView");
//	return 1;
//}
//
//// returns the number of rows
//- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
//	NSLog(@"number of rows");
//	return [vendorPickerItems count];
//}
//
//
//#pragma mark ---- UIPickerViewDelegate delegate methods ----
//// returns the title of each row
//- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
//	NSLog(@"title of each row");
//	Vendor *currentVendor = [vendorPickerItems objectAtIndex:row];
//	return currentVendor.name;
//}
//
//// gets called when the user settles on a row
//- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
//	vendor = [vendorPickerItems objectAtIndex:row];
//}


/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

NSInteger sortByTop(id control1, id control2, void *reverse) {
	
	int top1 = ((UITextField *)control1).center.y;
	int top2 = ((UITextField *)control2).center.y;
	
	if (top1 < top2)
		return NSOrderedAscending;
	else if (top1 > top2)
		return NSOrderedDescending;
	else
		return NSOrderedSame;
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
//	self.vendorPickerItems =  [[NSArray alloc] initWithArray:[Vendor findByExpenseType:self.expenseType]];
	
	[self registerForKeyboardNotifications];
	
	[scrollView setContentSize:CGSizeMake(self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
	[scrollView addSubview:self.contentView];
	[self populateTextFieldsArraySortedByPosition];
	[self addDropDownButtonToTextView];
	
}

- (void)populateTextFieldsArraySortedByPosition {
	self.textFields = [[NSMutableArray alloc] init];
	
	NSArray *sortedArray = [[contentView subviews] sortedArrayUsingFunction:sortByTop context:NULL];
	for (UIView *curentView in sortedArray) {
		if ([curentView isKindOfClass:[UITextField class]])
			[self.textFields addObject:curentView];
	}
}

- (void)addDropDownButtonToTextView {
	UIImage *downArrowImage = [UIImage imageNamed:@"DownArrow24x24.png"];
	for (UITextField *currentTextField in self.textFields) {
		UIButton *downArrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[downArrowButton setFrame:CGRectMake(0, 0, 24, 24)];
		[downArrowButton setImage:downArrowImage forState:UIControlStateNormal];
		currentTextField.rightViewMode = UITextFieldViewModeAlways;
		currentTextField.rightView = downArrowButton;
		
		[downArrowButton addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchDown];
		[currentTextField setDelegate:self];
	}
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark --- Keyboard popup handling methods ----
// Call this method somewhere in your view controller setup code.
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWasShown:)
												 name:UIKeyboardDidShowNotification object:nil];
	
    [[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(keyboardWasHidden:)
												 name:UIKeyboardDidHideNotification object:nil];
	
	[self.previousButton	addTarget:self action:@selector(tabToPreviousControl)	forControlEvents:UIControlEventTouchDown];
	[self.nextButton		addTarget:self action:@selector(tabToNextControl)		forControlEvents:UIControlEventTouchDown];
	[self.doneButton		addTarget:self action:@selector(tabDoneControl)			forControlEvents:UIControlEventTouchDown];
}

// Called when the UIKeyboardDidShowNotification is sent.
- (void)keyboardWasShown:(NSNotification*)aNotification
{
    if (keyboardShown)
        return;
	
    NSDictionary* info = [aNotification userInfo];
	
    // Get the size of the keyboard.
    NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
	
	NSLog(@"The size of keyboard is: height=>%f and width=>%f", keyboardSize.height, keyboardSize.width);
	
	// Display the tab selector view
	[scrollView.superview addSubview:self.navigationPopupView];
	long y = scrollView.superview.bounds.size.height + 44 - keyboardSize.height - (navigationPopupView.bounds.size.height/2);
	navigationPopupView.center = CGPointMake(navigationPopupView.center.x, y);
	
	
    // Resize the scroll view (which is the root view of the window)
    CGRect viewFrame = [scrollView frame];
    //viewFrame.size.height -= (keyboardSize.height + navigationPopupView.bounds.size.height);
	viewFrame.size.height = scrollView.superview.frame.size.height + 44 - (keyboardSize.height + navigationPopupView.bounds.size.height);
    scrollView.frame = viewFrame;
	
    // Scroll the active text field into view.
    CGRect textFieldRect = [activeField frame];
    [self.scrollView scrollRectToVisible:textFieldRect animated:YES];
	
    keyboardShown = YES;
}

- (IBAction)showPicker:(UIButton *)sender {
	if (activeField != NULL)
		[activeField resignFirstResponder];
	activeField = (UITextField *)sender.superview;
	
	
	[scrollView.superview addSubview:self.datePickerView];
	long y = scrollView.superview.bounds.size.height + 44 - (self.datePickerView.bounds.size.height/2);
	
	self.datePickerView.center = CGPointMake(navigationPopupView.center.x, y);
	
	if (keyboardShown)
		return;
	
	[scrollView.superview addSubview:self.navigationPopupView];
	
	y = scrollView.superview.bounds.size.height + 44 - datePickerView.bounds.size.height - (navigationPopupView.bounds.size.height/2);
	navigationPopupView.center = CGPointMake(navigationPopupView.center.x, y);
}

// Called when the UIKeyboardDidHideNotification is sent
- (void)keyboardWasHidden:(NSNotification*)aNotification
{
    NSDictionary* info = [aNotification userInfo];
	
    // Get the size of the keyboard.
    NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
	
    // Reset the height of the scroll view to its original value
    CGRect viewFrame = [scrollView frame];
    viewFrame.size.height += keyboardSize.height;
    scrollView.frame = viewFrame;
	
    keyboardShown = NO;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
	NSLog(@"The field is active %@", textField);
    activeField = textField;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //activeField = nil;
}

- (IBAction)tabToPreviousControl {
	[self makeControlFirstResponder:FALSE];
}

- (IBAction)tabToNextControl {
	[self makeControlFirstResponder:TRUE];	
}

- (IBAction)tabDoneControl {
	[activeField resignFirstResponder];
	[self.datePickerView removeFromSuperview];
	[self.navigationPopupView removeFromSuperview];
}

- (void)makeControlFirstResponder:(BOOL)next{
	int indexOfCurrentObject = [self.textFields indexOfObject:activeField];
	if (next == TRUE) {
		int nextIndexOfCurrentObject = indexOfCurrentObject == ([self.textFields count] - 1) ? 0 : indexOfCurrentObject + 1;
		[[self.textFields objectAtIndex:nextIndexOfCurrentObject] becomeFirstResponder];
	}
	else {
		int previousIndexOfCurrentObject = indexOfCurrentObject == 0 ? ([self.textFields count] - 1) : indexOfCurrentObject - 1;
		[[self.textFields objectAtIndex:previousIndexOfCurrentObject] becomeFirstResponder];
	}
}


# pragma mark --- Deallocation method ----
- (void)dealloc {
	
	[self.expenseType				dealloc];
	[self.vendor					dealloc];
	
	[self.mainView 					dealloc];
	[self.scrollView				dealloc];
	[self.contentView				dealloc];
	[self.navigationPopupView		dealloc];
	[self.datePickerView			dealloc];
	[self.genericPickerView			dealloc];
		
	[self.vendorField				dealloc];
	[self.dateField					dealloc];
	[self.currencyField				dealloc];
	[self.amountField				dealloc];
	[self.projectField				dealloc];
	[self.attendesField				dealloc];
	[self.textFields				dealloc];
	
	[self.previousButton			dealloc];
	[self.nextButton				dealloc];
	[self.doneButton				dealloc];	
	
    [super dealloc];
}


@end


