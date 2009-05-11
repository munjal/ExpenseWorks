#import "ExpenseReport.h"


@implementation ExpenseReport

@synthesize reportId;
@synthesize createdOn;
@synthesize submittedOn;

- (void) dealloc {
	[reportId release];
	[createdOn release];
	[submittedOn release];
	[super dealloc];
}

- (NSString *) description {
	return [NSString stringWithFormat:@"Report: %@; createdOn: %@ submittedOn: %@", self.reportId, self.createdOn, self.submittedOn];
}

@end
