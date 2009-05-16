#import "ExpenseType.h"


@implementation ExpenseType

@synthesize typeId;
@synthesize name;

- (void) dealloc {
	[typeId release];
	[name release];
	[super dealloc];
}

- (NSString *) description {
	return [NSString stringWithFormat:@"TypeId: %@; Name: %@", self.typeId, self.name];
}

@end
