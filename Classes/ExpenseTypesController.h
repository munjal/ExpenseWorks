//
//  ExpenseTypesController.h
//  ExpenseWorks
//
//  Created by mbudhabh on 5/15/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ExpenseTypesController : UITableViewController {
	NSArray *expenseTypes;
}
@property (nonatomic, retain) NSArray *expenseTypes;
@end
