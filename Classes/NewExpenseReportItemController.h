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

@interface NewExpenseReportItemController : UIViewController <UIPickerViewDelegate> {
	ExpenseType							*expenseType;
	
	IBOutlet UISegmentedControl			*segmentedControl;
	IBOutlet UIView						*mainView;
	IBOutlet UIView						*amountDateView;
	IBOutlet UIView						*vendorClientView;
	
	IBOutlet UITextField				*projectCode;

	IBOutlet UIPickerView				*vendorPickerView;
	Vendor								*vendor;
	NSArray								*vendorPickerItems;
	
	IBOutlet UITextField				*amount;
	IBOutlet UIDatePicker				*datePicker;
//	IBOutlet UIPickerView	*
}

@property (nonatomic, retain) ExpenseType				*expenseType;
@property (nonatomic, retain) UISegmentedControl		*segmentedControl;
@property (nonatomic, retain) UIView					*mainView;
@property (nonatomic, retain) UIView					*amountDateView;
@property (nonatomic, retain) UIView					*vendorClientView;

@property (nonatomic, retain) UITextField				*projectCode;

@property (nonatomic, retain) Vendor					*vendor;
@property (nonatomic, retain) UIPickerView				*vendorPickerView;
@property (nonatomic, retain) NSArray					*vendorPickerItems;

- (IBAction)segmentedControlValueChanged:(id)sender;
- (void) showView:(UIView *)view;

@end
