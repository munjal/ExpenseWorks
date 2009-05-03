//
//  ExpenseWorksAppDelegateTest.m
//  ExpenseWorks
//
//  Created by mbudhabh on 5/3/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//
//  Link to Google Toolbox For Mac (IPhone Unit Test): 
//					http://code.google.com/p/google-toolbox-for-mac/wiki/iPhoneUnitTesting
//  Link to OCUnit:	http://www.sente.ch/s/?p=276&lang=en
//  Link to OCMock:	http://www.mulle-kybernetik.com/software/OCMock/



#import <UIKit/UIKit.h>
//#import <OCMock/OCMock.h>
//#import <OCMock/OCMConstraint.h>
#import "GTMSenTestCase.h"
//#import "application_headers" as required

@interface ExpenseWorksAppDelegateTest : GTMTestCase {
	id mock; // Mock object used in tests	
}
@end

@implementation ExpenseWorksAppDelegateTest

#if TARGET_IPHONE_SIMULATOR     // Only run when the target is simulator

//- (void) setUp {
//	mock = [OCMockObject mockForClass:[NSString class]];  // create your mock objects here
//	// Create shared data structures here
//}

// Start all test methods with testXXX
- (void) testMath {
    STAssertTrue((1+1)==2, @"Compiler isn't feeling well today :-(" );
}

- (void) tearDown {
    // Release data structures here.
}

#endif

@end
