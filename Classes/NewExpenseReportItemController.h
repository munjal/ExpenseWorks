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
	IBOutlet UITextField	*projectCode;
	IBOutlet UIPickerView	*vendorPickerView;
	NSArray					*vendorPickerItems;
	ExpenseType				*expenseType;
	Vendor					*vendor;
}
@property (nonatomic, retain) UITextField		*projectCode;
@property (nonatomic, retain) ExpenseType		*expenseType;
@property (nonatomic, retain) UIPickerView		*vendorPickerView;
@property (nonatomic, retain) NSArray			*vendorPickerItems;
@property (nonatomic, retain) Vendor			*vendor;

@end
