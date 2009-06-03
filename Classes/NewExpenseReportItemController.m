#import "NewExpenseReportItemController.h"
@implementation NewExpenseReportItemController

@synthesize expenseType;
@synthesize vendors, currencies, paymentTypes, projects, attendes;
@synthesize activePickerArray, modelToTextFieldMapper;

@synthesize mainView, scrollView, contentView, navigationPopupView, datePickerView, genericPickerView;
@synthesize vendorField, dateField, currencyField, amountField, paymentTypeField,projectField, attendesField, textFields;
@synthesize genericPicker, datePicker;
@synthesize previousButton, nextButton, doneButton;

#pragma mark ---- UIPickerViewDataSource delegate methods ----

// returns the number of columns to display.
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
	return 1;
}

// returns the number of rows
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
	return [[self pickerArrayForTextField:activeField] count];
}


#pragma mark ---- UIPickerViewDelegate delegate methods ----
// returns the title of each row
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	return [[[self pickerArrayForTextField:activeField] objectAtIndex:row] name];
}

// gets called when the user settles on a row
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	activeField.text = [[[self pickerArrayForTextField:activeField] objectAtIndex:row] name];
	//vendor = [vendors objectAtIndex:row];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	[self populatePickerItems];
	
	[self registerForKeyboardNotifications];
	
	[scrollView setContentSize:CGSizeMake(self.contentView.bounds.size.width, self.contentView.bounds.size.height)];
	[scrollView addSubview:self.contentView];
	[self populateTextFieldsArraySortedByPositionAndAddDropDownButtonToEachTextField];
	
}

- (void)populatePickerItems {
	self.vendors =  [NSArray arrayWithArray:[Vendor findByExpenseType:self.expenseType]];
	self.currencies = [NSArray arrayWithArray:[Currency findByCriteria:@" ORDER BY last_selected_on DESC"]];
	self.paymentTypes = [NSArray arrayWithArray:[PaymentType findByCriteria:@" ORDER BY last_selected_on DESC"]];
	self.projects = [NSArray arrayWithArray:[Project findByCriteria:@" ORDER BY last_selected_on DESC"]];
	self.attendes = [NSArray arrayWithArray:[Attendee findByCriteria:@" ORDER BY last_selected_on DESC"]];

	self.modelToTextFieldMapper = [[NSDictionary alloc] 
								   initWithObjects: [[NSArray alloc] initWithObjects:
													 self.vendors, 
													 self.currencies, 
													 self.paymentTypes,
													 self.projects,
													 self.attendes,
													 nil]
										   forKeys: [[NSArray alloc] initWithObjects:
													 [NSNumber numberWithInt:self.vendorField.hash], 
													 [NSNumber numberWithInt:self.currencyField.hash], 
													 [NSNumber numberWithInt:self.paymentTypeField.hash],
													 [NSNumber numberWithInt:self.projectField.hash],
													 [NSNumber numberWithInt:self.attendesField.hash],
													 nil
								   ]];
}

- (BOOL)dropDownButtonRequiredFor:(UITextField *)textField{
	return ([textField tag] > 1) ? TRUE : FALSE;
}

- (void)populateTextFieldsArraySortedByPositionAndAddDropDownButtonToEachTextField {
	self.textFields = [[NSMutableArray alloc] init];

	NSArray *sortedArray = [[contentView subviews] sortedArrayUsingFunction:sortByTop context:NULL];
	for (UIView *curentView in sortedArray) {
		if ([curentView isKindOfClass:[UITextField class]]){
			UITextField *currentTextField = (UITextField *)curentView;
			[currentTextField setDelegate:self];
			[self.textFields addObject:currentTextField];
			if ([self dropDownButtonRequiredFor:currentTextField]) {
				[self addButtonInRightViewModeTo:currentTextField];
			}
		}
			
	}
}

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


- (void) addButtonInRightViewModeTo:(UITextField *)textField {
	textField.rightViewMode = UITextFieldViewModeAlways;
	textField.rightView = [self createDropDownButton];
}

- (UIButton *)createDropDownButton {
	UIImage *downArrowImage = [UIImage imageNamed:@"DownArrow24x24.png"];
	UIButton *downArrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[downArrowButton setFrame:CGRectMake(0, 0, 24, 24)];
	[downArrowButton setImage:downArrowImage forState:UIControlStateNormal];
	[downArrowButton addTarget:self action:@selector(showPicker:) forControlEvents:UIControlEventTouchDown];
	return downArrowButton;
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

- (void)scrollActiveTextFieldIntoView {
    // Scroll the active text field into view.
      CGRect textFieldRect = [activeField frame];
    [self.scrollView scrollRectToVisible:textFieldRect animated:YES];

}
- (void)resizeScrollViewForKeyboardOrPopupViewDisplay:(CGSize)keyboardSize {
	CGRect viewFrame = [scrollView frame];
	viewFrame.size.height = scrollView.superview.frame.size.height + 24 - (keyboardSize.height + navigationPopupView.bounds.size.height);
    scrollView.frame = viewFrame;
}

- (TextViewTypes)textViewTypeFor:(UITextField *)textField {
	TextViewTypes activeViewType = None;
	if (textField != nil)
		activeViewType = [textField tag];
	return activeViewType;
}

- (TextViewTypes)activeFieldTextViewType {
	return [self textViewTypeFor:activeField];
}

- (void)keyboardWasShown:(NSNotification*)aNotification
{
	NSLog(@"Tag is %d", [self activeFieldTextViewType]);
		
    if (keyboardShown)
        return;
	
    NSDictionary* info = [aNotification userInfo];
	
    // Get the size of the keyboard.
    NSValue* aValue = [info objectForKey:UIKeyboardBoundsUserInfoKey];
    CGSize keyboardSize = [aValue CGRectValue].size;
	
	// Display the tab selector view
	[scrollView.superview addSubview:self.navigationPopupView];
	long y = scrollView.superview.bounds.size.height + 24 - keyboardSize.height - (navigationPopupView.bounds.size.height/2);
	navigationPopupView.center = CGPointMake(navigationPopupView.center.x, y);
	
	
	[self resizeScrollViewForKeyboardOrPopupViewDisplay:keyboardSize];

	
	[self scrollActiveTextFieldIntoView];

	
    keyboardShown = YES;
	navigationPopupShown = FALSE;
}


- (NSArray *)pickerArrayForTextField:(UITextField *)textField {
	return (NSArray *) [self.modelToTextFieldMapper objectForKey:[NSNumber numberWithInt:activeField.hash]];
}


- (IBAction)showPicker:(UIButton *)sender {
	if (activeField != NULL)
		[activeField resignFirstResponder];
	
	navigationPopupShown = TRUE;
	activeField.backgroundColor = nil;
	
	
	activeField = (UITextField *)sender.superview;
	
	activeField.backgroundColor = [UIColor blueColor];
	
	UIView *pickerViewToDisplay;
	if (activeField == self.dateField)
		pickerViewToDisplay = self.datePickerView;
	else {
		pickerViewToDisplay = self.genericPickerView;
		[self.genericPicker reloadAllComponents];
	}
		
	activeField.text = 	[[[self pickerArrayForTextField:activeField] objectAtIndex:0] name];
	
	[scrollView.superview addSubview:pickerViewToDisplay];
	long y = scrollView.superview.bounds.size.height + 24 - (pickerViewToDisplay.bounds.size.height/2);
	
	pickerViewToDisplay.center = CGPointMake(navigationPopupView.center.x, y);
	
	[self resizeScrollViewForKeyboardOrPopupViewDisplay:datePickerView.bounds.size];
	
	
	if (keyboardShown)
		return;
	
	[scrollView.superview addSubview:self.navigationPopupView];
	
	y = scrollView.superview.bounds.size.height + 24 - pickerViewToDisplay.bounds.size.height - (navigationPopupView.bounds.size.height/2);
	navigationPopupView.center = CGPointMake(navigationPopupView.center.x, y);	
}

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
	activeField.backgroundColor = nil;
    activeField = textField;
	activeField.backgroundColor = [UIColor blueColor];
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    //activeField = nil;
}

- (IBAction)tabToPreviousControl {
	activeField.backgroundColor = nil;
	[self makeControlFirstResponder:FALSE];
	if (!keyboardShown) {
		[self resizeScrollViewForKeyboardOrPopupViewDisplay:datePickerView.bounds.size];
	}
	[self scrollActiveTextFieldIntoView];
	activeField.backgroundColor = [UIColor blueColor];
}

- (IBAction)tabToNextControl {
	activeField.backgroundColor = nil;
	[self makeControlFirstResponder:TRUE];	
	if (!keyboardShown) {
		[self resizeScrollViewForKeyboardOrPopupViewDisplay:datePickerView.bounds.size];
	}
	[self scrollActiveTextFieldIntoView];
	activeField.backgroundColor = [UIColor blueColor];
}


- (IBAction)tabDoneControl {
	activeField.backgroundColor = nil;
	[activeField resignFirstResponder];
	[self.genericPickerView removeFromSuperview];
	[self.datePickerView removeFromSuperview];
	[self.navigationPopupView removeFromSuperview];
	[self resizeScrollViewForKeyboardOrPopupViewDisplay:CGSizeMake(0, 0)];
}

- (void)makeControlFirstResponder:(BOOL)next{
	UITextField *currentField;
	int indexOfCurrentObject = [self.textFields indexOfObject:activeField];
	if (next == TRUE) {
		int nextIndexOfCurrentObject = indexOfCurrentObject == ([self.textFields count] - 1) ? 0 : indexOfCurrentObject + 1;
		currentField = [self.textFields objectAtIndex:nextIndexOfCurrentObject];
	}
	else {
		int previousIndexOfCurrentObject = indexOfCurrentObject == 0 ? ([self.textFields count] - 1) : indexOfCurrentObject - 1;
		currentField = [self.textFields objectAtIndex:previousIndexOfCurrentObject];
	}
	if ((keyboardShown) || ([self textViewTypeFor:currentField] == TextView))
		[currentField becomeFirstResponder];
	else{
		for (UIView *currentView in [currentField subviews]) {
			if ([currentView isKindOfClass:[UIButton class]]) {
				[self showPicker:(UIButton *)currentView];
				return;
			}
		}
	}
		
}

//TODO using this
- (void)selectRowInPicker:(UIView *)pickerViewToDisplay {
	if (pickerViewToDisplay == self.genericPickerView) {
		[self.genericPicker selectRow:2 inComponent:0 animated:TRUE];
	}	
}



# pragma mark --- Deallocation method ----
- (void)dealloc {
	
	[self.expenseType				dealloc];
	[self.vendors					dealloc];
	[self.currencies				dealloc];
	[self.paymentTypes				dealloc];
	[self.projects					dealloc];
	[self.attendes					dealloc];
	
	[self.activePickerArray			dealloc];
	[self.modelToTextFieldMapper	dealloc];
	
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
	[self.paymentTypeField			dealloc];
	[self.projectField				dealloc];
	[self.attendesField				dealloc];
	[self.textFields				dealloc];
	
	[self.genericPicker				dealloc];
	[self.datePicker				dealloc];
	
	[self.previousButton			dealloc];
	[self.nextButton				dealloc];
	[self.doneButton				dealloc];	
	
    [super dealloc];
}


@end


