
#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface ExpenseReportItem : SQLitePersistentObject {
	NSString	*project;
	NSString	*category;
	NSDate		*date;
	NSString	*currency;
	NSNumber	*amount;
	NSString	*description;
	NSString	*vendor;
	NSString	*payment;
	NSString	*attendes;
}

@property (nonatomic, retain) NSString	*project;
@property (nonatomic, retain) NSString	*category;
@property (nonatomic, retain) NSDate	*date;
@property (nonatomic, retain) NSString	*currency;
@property (nonatomic, retain) NSNumber	*amount;
@property (nonatomic, retain) NSString	*description;
@property (nonatomic, retain) NSString	*vendor;
@property (nonatomic, retain) NSString	*payment;
@property (nonatomic, retain) NSString	*attendes;

@end
