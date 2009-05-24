
#import "_XParameterSet.h"

/*
#import "XObject.h"

@interface _XParameterSet : XObject {  
  id _callbackName;
  BOOL _hasParam1;
  BOOL _hasParam2;
  id _methodToPerform;
  id _param1;
  id _param2;
}
@end
*/

@implementation _XParameterSet

+ (void) initialize {
  [self ivarReaders:@"callbackName", @"methodToPerform", @"param1", @"param2", nil];
}

- (void) dealloc {
  [super dealloc];
}

// public instance methods

- (BOOL) hasCallback {
  return (_callbackName) ? YES : NO;
}

- (BOOL) hasParam1 {
  return _hasParam1;
}

- (BOOL) hasParam2 {
  return _hasParam2;
}


@end
