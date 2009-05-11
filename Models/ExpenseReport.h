#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"

@interface ExpenseReport : SQLitePersistentObject {
	NSString		*reportId;
	NSDate			*createdOn;
	NSDate			*submittedOn;	
}

@property (nonatomic, retain) NSString	*reportId;
@property (nonatomic, retain) NSDate	*createdOn;
@property (nonatomic, retain) NSDate	*submittedOn;

@end
