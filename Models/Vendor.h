#import <Foundation/Foundation.h>
#import "SQLitePersistentObject.h"
#import "ExpenseType.h"

@interface Vendor : SQLitePersistentObject {
	NSString		*name;
	ExpenseType		*expenseType;
}

@property (nonatomic, retain) NSString		*name;
@property (nonatomic, retain) ExpenseType	*expenseType;

+ (NSArray *)findByExpenseType:(ExpenseType *)expenseType;

@end
