#import "NSDateFormatter+X.h"

/*
@interface NSDateFormatter (X)
@end
*/

@implementation NSDateFormatter (X)

+ (id) railsFormatter {
  id result = [self with:@"yyyy-MM-dd'T'HH:mm:ss'Z'"];
  [result setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
  return result;
}

+ (id) with: (id)formatString {
  id formatter = [[NSDateFormatter alloc] init];
  [formatter setDateFormat:formatString];    
  return [formatter autorelease];
}

@end
