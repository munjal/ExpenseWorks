
#import "XTriplet.h"

/*
#import "XObject.h"

@interface XTriplet : XObject {  
  id _firstValue;
  id _secondValue;
  id _thirdValue;
}
@end
*/

@implementation XTriplet

// initializer/class factory methods/constructors/destructor
  
+ (void) initialize {
  [self attrAccessors:@"firstValue", @"secondValue", @"thirdValue", nil];
} 
 
+ (id) with: (id)firstValue and: (id)secondValue and: (id)thirdValue {
  return [[[self alloc] initWith:firstValue and:secondValue and:thirdValue] autorelease];
}

- (id) initWith: (id)firstValue and: (id)secondValue and: (id)thirdValue {
  if (self = [super init]) {
    _firstValue = [firstValue retain];
    _secondValue = [secondValue retain];
    _thirdValue = [thirdValue retain];
  }
  return self;
}
  
- (void) dealloc {
	[_firstValue release];
	[_secondValue release];    
  [_thirdValue release];    
	[super dealloc];
}
  
  
@end