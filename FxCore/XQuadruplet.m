
#import "XQuadruplet.h"

/*
#import "XObject.h"

@interface XQuadruplet : XObject {  
  id _firstValue;
  id _secondValue;
  id _thirdValue;
  id _fourthValue;
}
@end
*/

@implementation XQuadruplet

// initializer/class factory methods/constructors/destructor
  
+ (void) initialize {
  [self attrAccessors:@"firstValue", @"secondValue", @"thirdValue", @"fourthValue", nil];
} 
 
+ (id) with: (id)firstValue and: (id)secondValue and: (id)thirdValue and: (id)fourthValue {
  return [[[self alloc] initWith:firstValue and:secondValue and:thirdValue and:fourthValue] autorelease];
}

- (id) initWith: (id)firstValue and: (id)secondValue and: (id)thirdValue and: (id)fourthValue {
  if (self = [super init]) {
    _firstValue = [firstValue retain];
    _secondValue = [secondValue retain];
    _thirdValue = [thirdValue retain];
    _fourthValue = [fourthValue retain];
  }
  return self;
}
  
- (void) dealloc {
	[_firstValue release];
	[_fourthValue release];
	[_secondValue release];    
  [_thirdValue release];    
	[super dealloc];
}
  
  
@end