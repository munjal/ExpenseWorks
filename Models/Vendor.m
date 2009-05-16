#import "Vendor.h"


@implementation Vendor

@synthesize name;
@synthesize expenseType;

- (void) dealloc {
	[name release];
	[expenseType release];
	[super dealloc];
}

- (NSString *) description {
	return [NSString stringWithFormat:@"Name: %@, Expense Type: %@", self.name, self.expenseType];
}

+ (NSArray *) findByExpenseType:(ExpenseType*) expenseType {
	NSString *criteria = [NSString stringWithFormat:@"where expense_type = 'ExpenseType-%d'", expenseType.pk];
	return [Vendor findByCriteria:criteria];
}
@end
