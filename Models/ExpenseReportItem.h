
#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"
#import "ExpenseReport.h"

@interface ExpenseReportItem : SQLitePersistentObject {
	NSString		*reportId;
	NSString		*project;
	NSString		*category;
	NSDate			*date;
	NSString		*currency;
	float			amount;
	NSString		*remarks;
	NSString		*vendor;
	NSString		*payment;
	NSString		*attendes;
	
	ExpenseReport	*expenseReport;
}

@property (nonatomic, retain) NSString  *reportId;
@property (nonatomic, retain) NSString	*project;
@property (nonatomic, retain) NSString	*category;
@property (nonatomic, retain) NSDate	*date;
@property (nonatomic, retain) NSString	*currency;
@property (nonatomic) float				amount;
@property (nonatomic, retain) NSString	*remarks;
@property (nonatomic, retain) NSString	*vendor;
@property (nonatomic, retain) NSString	*payment;
@property (nonatomic, retain) NSString	*attendes;

@property (nonatomic, retain) ExpenseReport *expenseReport;

@end
