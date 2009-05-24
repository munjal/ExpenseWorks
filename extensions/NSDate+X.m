#import "NSDate+X.h"

#import "NSDateFormatter+X.h"
/*
@interface NSDate (X)
@end
*/

@implementation NSDate (X)

+ (id) from: (id)dateString format: (id)format {
  id formatter = [NSDateFormatter with:format];
  return [formatter dateFromString:dateString];
}

+ (id) fromRailsFormat: (id)dateString {
  id formatter = [NSDateFormatter railsFormatter];
  return [formatter dateFromString:dateString];
}

+ (id) now {
  return [self date];
}

- (id) asRailsString {
  id formatter = [NSDateFormatter railsFormatter];
  return [formatter stringFromDate:self];
}

- (BOOL) isEarlierThan: (id)other {
  return [self compare:other] == NSOrderedAscending;
}

- (BOOL) isLaterThan: (id)other {
  return [self compare:other] == NSOrderedDescending;
}

@end
