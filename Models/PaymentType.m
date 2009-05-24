#import "PaymentType.h"


@implementation PaymentType

@synthesize name;
@synthesize lastSelectedOn;

- (void) dealloc {
	[name release];
	[lastSelectedOn release];
	[super dealloc];
}

- (NSString *) description {
	return [NSString stringWithFormat:@"Name: %@ and Last Selected On: %@", self.name, self.lastSelectedOn];
}

@end
