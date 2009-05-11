#import "ExpenseReportItem.h"

@implementation ExpenseReportItem

@synthesize reportId;
@synthesize project;
@synthesize category;
@synthesize date;
@synthesize currency;
@synthesize amount;
@synthesize remarks;
@synthesize vendor;
@synthesize payment;
@synthesize attendes;

@synthesize expenseReport;

- (void)dealloc {
	[reportId release];
	[project release];
	[category release];
	[date release];
	[currency release];
	[remarks release];
	[vendor release];
	[payment release];
	[attendes release];
	[expenseReport release];
	
	[super dealloc];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"reportId: %@; project: %@; category: %@; date: %@; currency: %@; remarks: %@; vendor: %@; payment: %@; attendes: %@; expenseReport: %@;",
			self.reportId, self.project, self.category, self.date, self.currency, self.remarks, self.vendor, 
			self.payment, self.attendes, self.expenseReport
	
			];
}

@end
