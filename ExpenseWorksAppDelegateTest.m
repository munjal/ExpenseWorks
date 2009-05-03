#import <UIKit/UIKit.h>
#import <OCMock/OCMock.h>
#import <OCMock/OCMConstraint.h>
#import "GTMSenTestCase.h"
//#import "application_headers" as required

@interface ExpenseWorksAppDelegateTest : GTMTestCase {
	id mock; // Mock object used in tests	
}
@end

@implementation ExpenseWorksAppDelegateTest

#if TARGET_IPHONE_SIMULATOR     // Only run when the target is simulator

- (void) setUp {
	mock = [OCMockObject mockForClass:[NSString class]];  // create your mock objects here
	// Create shared data structures here
}

- (void) testMath {
    STAssertTrue((1+1)==2, @"Compiler isn't feeling well today :-(" );
	STAssertThrows([mock uppercaseString], @"Should have raised an exception.");
}

- (void) tearDown {
}

#endif

@end
