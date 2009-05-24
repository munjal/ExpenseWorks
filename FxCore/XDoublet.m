#import "XDoublet.h"

#import "XString.h"

/*
#import "XObject.h"

@interface XDoublet : XObject {  
id _firstValue;
id _secondValue;
}
@end
*/

@implementation XDoublet 

// initializer/class factory methods/constructors/destructor
  
+ (void) initialize {
  [self attrAccessors:@"firstValue", @"secondValue", nil];
} 
 
+ (id) with: (id)firstValue and: (id)secondValue {
  return [[[self alloc] initWith:firstValue and:secondValue] autorelease];
}

- (id) initWith: (id)firstValue and: (id)secondValue {
  if (self = [super init]) {
    _firstValue = [firstValue retain];
    _secondValue = [secondValue retain];
  }
  return self;
}
  
- (void) dealloc {
	[_firstValue release];
	[_secondValue release];    
	[super dealloc];
}
  
// public instance methods

- (id) description {
  return [XString withFormat:@"(%@, %@)", _firstValue, _secondValue, nil];
}  

  
@end