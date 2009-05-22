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

//@interface NewExpenseReportItemController : UIViewController <UIPickerViewDelegate> {
@interface NewExpenseReportItemController : UIViewController <UITextFieldDelegate> {
	ExpenseType							*expenseType;
	Vendor								*vendor;
	
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
	IBOutlet UITextField				*projectField;
	IBOutlet UITextField				*attendesField;
	NSMutableArray						*textFields;
	
//	IBOutlet UIPickerView				*vendorPickerView;
//	NSArray								*vendorPickerItems;
	
	IBOutlet UIButton					*previousButton;
	IBOutlet UIButton					*nextButton;
	IBOutlet UIButton					*doneButton;
	
	BOOL			keyboardShown;
	UITextField		*activeField;
	
}

@property (nonatomic, retain) ExpenseType				*expenseType;
@property (nonatomic, retain) Vendor					*vendor;

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
@property (nonatomic, retain) UITextField				*projectField;
@property (nonatomic, retain) UITextField				*attendesField;
@property (nonatomic, retain) NSMutableArray			*textFields;

@property (nonatomic, retain) IBOutlet UIButton			*previousButton;
@property (nonatomic, retain) IBOutlet UIButton			*nextButton;
@property (nonatomic, retain) IBOutlet UIButton			*doneButton;

//@property (nonatomic, retain) UIPickerView				*vendorPickerView;
//@property (nonatomic, retain) NSArray					*vendorPickerItems;


- (void)textFieldDidBeginEditing:(UITextField *)textField;
- (void)textFieldDidEndEditing:(UITextField *)textField;
- (void)registerForKeyboardNotifications;

- (IBAction)tabToPreviousControl;
- (IBAction)tabToNextControl;
- (IBAction)tabDoneControl;

- (void)populateTextFieldsArraySortedByPosition;
- (void)addDropDownButtonToTextView;

- (IBAction)showPicker:(UIButton *)sender;
- (void)makeControlFirstResponder:(BOOL)next;

@end
