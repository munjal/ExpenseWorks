#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface ExpenseReport : SQLitePersistentObject {
	NSString		*report_id;
	NSDate			*created_date;
	NSDate			*submitted_date;	
}

@property (nonatomic, retain) NSString	*report_id;
@property (nonatomic, retain) NSDate	*created_date;
@property (nonatomic, retain) NSDate	*submitted_date;

@end
