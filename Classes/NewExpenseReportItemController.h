//
//  NewExpenseReportItemController.h
//  ExpenseWorks
//
//  Created by mbudhabh on 5/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ExpenseType.h"
#import "Vendor.h"
#import "Currency.h"
#import "PaymentType.h"
#import "Project.h"
#import "Attendee.h"

typedef enum TextViewTypes {
	None = 0,
	TextView = 1,
	DropDownView = 2,
	EditableDropDownView = 4,
	DateView = 8
} TextViewTypes;

@interface NewExpenseReportItemController : UIViewController <UITextFieldDelegate, UIPickerViewDelegate> {
	ExpenseType							*expenseType;
	NSArray								*vendors;
	NSArray								*currencies;
	NSArray								*paymentTypes;
	NSArray								*projects;
	NSArray								*attendes;
	
	NSArray								*activePickerArray;
	NSDictionary						*modelToTextFieldMapper;
	
	IBOutlet UIView						*mainView;
	IBOutlet UIScrollView				*scrollView;
	IBOutlet UIView						*contentView;
	IBOutlet UIView						*navigationPopupView;
	IBOutlet UIView						*datePickerView;
	IBOutlet UIView						*genericPickerView;
	
	IBOutlet UITextField				*vendorField;
	IBOutlet UITextField				*dateField;
	IBOutlet UITextField				*currencyField;
	IBOutlet UITextField				*amountField;
	IBOutlet UITextField				*paymentTypeField;
	IBOutlet UITextField				*projectField;
	IBOutlet UITextField				*attendesField;
	NSMutableArray						*textFields;
	UITextField							*activeField;
	
	IBOutlet UIPickerView				*genericPicker;
	IBOutlet UIDatePicker				*datePicker;
	
	IBOutlet UIButton					*previousButton;
	IBOutlet UIButton					*nextButton;
	IBOutlet UIButton					*doneButton;
	
	BOOL								keyboardShown;
	BOOL								navigationPopupShown;
}

@property (nonatomic, retain) ExpenseType				*expenseType;
@property (nonatomic, retain) NSArray					*vendors;
@property (nonatomic, retain) NSArray					*currencies;
@property (nonatomic, retain) NSArray					*paymentTypes;
@property (nonatomic, retain) NSArray					*projects;
@property (nonatomic, retain) NSArray					*attendes;

@property (nonatomic, retain) NSArray					*activePickerArray;
@property (nonatomic, retain) NSDictionary				*modelToTextFieldMapper;

@property (nonatomic, retain) UIView					*mainView;
@property (nonatomic, retain) UIScrollView				*scrollView;
@property (nonatomic, retain) UIView					*contentView;
@property (nonatomic, retain) UIView					*navigationPopupView;
@property (nonatomic, retain) UIView					*datePickerView;
@property (nonatomic, retain) UIView					*genericPickerView;

@property (nonatomic, retain) UITextField				*vendorField;
@property (nonatomic, retain) UITextField				*dateField;
@property (nonatomic, retain) UITextField				*currencyField;
@property (nonatomic, retain) UITextField				*amountField;
@property (nonatomic, retain) UITextField				*paymentTypeField;
@property (nonatomic, retain) UITextField				*projectField;
@property (nonatomic, retain) UITextField				*attendesField;
@property (nonatomic, retain) NSMutableArray			*textFields;

@property (nonatomic, retain) UIPickerView				*genericPicker; 
@property (nonatomic, retain) UIDatePicker				*datePicker;

@property (nonatomic, retain) IBOutlet UIButton			*previousButton;
@property (nonatomic, retain) IBOutlet UIButton			*nextButton;
@property (nonatomic, retain) IBOutlet UIButton			*doneButton;

- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (void)registerForKeyboardNotifications;

- (IBAction)tabToPreviousControl;
- (IBAction)tabToNextControl;
- (IBAction)tabDoneControl;

- (TextViewTypes)textViewTypeFor:(UITextField *)textField;
- (TextViewTypes)activeFieldTextViewType;

NSInteger sortByTop(id control1, id control2, void *reverse);

- (BOOL)dropDownButtonRequiredFor:(UITextField *)textField;
- (void)populatePickerItems;
- (void)populateTextFieldsArraySortedByPositionAndAddDropDownButtonToEachTextField;

- (void)addButtonInRightViewModeTo:(UITextField *)textField;
- (UIButton *)createDropDownButton;

- (void)resizeScrollViewForKeyboardOrPopupViewDisplay:(CGSize)keyboardSize;

- (NSArray *)pickerArrayForTextField:(UITextField *)textField;
- (IBAction)showPicker:(UIButton *)sender;
- (void)makeControlFirstResponder:(BOOL)next;

@end
