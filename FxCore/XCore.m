#import "XCore.h"

BOOL equalOrBothNil(id first, id second)  {
  if (first == nil && second == nil) {
    return YES;
  }
  if (first != nil) {
    return [first isEqual:second];
  }
  return NO;
}
